#!/bin/bash

set -e

# Setup and generate video using Stable Video Diffusion
echo "Setting up Personal Journaling System video generator..."

# Create output directory
mkdir -p ~/journaling-video/outputs

# Create Python virtual environment
python3 -m venv ~/journaling-video/venv
source ~/journaling-video/venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install PyTorch with CUDA support
echo "Installing PyTorch with CUDA 12.1 support..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install video generation dependencies
echo "Installing video generation dependencies..."
pip install diffusers transformers accelerate omegaconf einops xformers imageio imageio-ffmpeg opencv-python pillow requests

# Create the video generation script
cat > generate_video.py << 'PYEOF'
import torch
import os
from diffusers import StableVideoDiffusionPipeline
from PIL import Image, ImageDraw
import imageio
import numpy as np

print("Initializing Stable Video Diffusion pipeline...")

# Check CUDA
device = "cuda" if torch.cuda.is_available() else "cpu"
print(f"Using device: {device}")
if device == "cuda":
    print(f"GPU: {torch.cuda.get_device_name(0)}")
    print(f"GPU Memory: {torch.cuda.get_device_properties(0).total_memory / 1024**3:.2f} GB")

# Create title frame
img_width, img_height = 1280, 720
title_frame = Image.new('RGB', (img_width, img_height), color=(20, 20, 30))
draw = ImageDraw.Draw(title_frame)

# Add text to title frame
text_lines = [
    "Personal Journaling System",
    "A Systematic Approach to Productivity & Focus",
    "From chaos to clarity in 12 weeks",
    "One voice journal per day. One dashboard. One system."
]

y_position = 250
for line in text_lines:
    draw.text((img_width//2 - 200, y_position), line, fill=(255, 255, 255))
    y_position += 80

# Save title frame
title_frame_path = "title_frame.png"
title_frame.save(title_frame_path)

# Load pipeline
print("Loading StableVideoDiffusionPipeline...")
pipeline = StableVideoDiffusionPipeline.from_pretrained(
    "stabilityai/stable-video-diffusion-img2vid-xt",
    torch_dtype=torch.float16,
    variant="fp16"
).to(device)

# Generate video from title frame
print("Generating video... (this may take 5-10 minutes)")
with torch.no_grad():
    frames = pipeline(
        title_frame,
        height=720,
        width=1280,
        num_frames=120,
        num_inference_steps=25,
        generator=torch.Generator(device=device).manual_seed(42)
    ).frames[0]

# Convert frames to numpy and duplicate to create ~4 minute video
frames_np = [np.array(frame) for frame in frames]
extended_frames = frames_np * 50  # Extend to ~6000 frames for 4 minutes at 24fps

# Save as MP4
output_path = os.path.expanduser("~/journaling-video/outputs/personal-journaling-demo.mp4")
print(f"Saving video to {output_path}...")
imageio.mimsave(output_path, extended_frames, fps=24, codec='libx264')

print("✓ Video generation complete!")
print(f"Output: {output_path}")
print(f"Duration: ~4 minutes")
print(f"Resolution: 1280×720")

# Cleanup
os.remove(title_frame_path)
PYEOF

# Run the video generation
python generate_video.py

echo "All done! Video saved to: ~/journaling-video/outputs/personal-journaling-demo.mp4"
