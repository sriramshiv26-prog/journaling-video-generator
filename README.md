# Personal Journaling System — Video Generator

Generate a professional 3-4 minute demo video locally using Stable Video Diffusion.

## Quick Start

```bash
bash setup_and_generate.sh
```

That's it! The script will:
1. Create a Python virtual environment
2. Install PyTorch with CUDA support
3. Install video generation dependencies
4. Generate the demo video
5. Save output to `~/journaling-video/outputs/personal-journaling-demo.mp4`

## System Requirements

- **GPU:** NVIDIA GPU with 12GB+ VRAM (tested on RTX 5060)
- **OS:** Linux, Windows (WSL2), or macOS
- **Python:** 3.10+
- **CUDA:** Automatically installed by the script for GPU machines

## Timing

- **First run:** 25-30 minutes (includes PyTorch installation)
- **Subsequent runs:** 15-20 minutes (video generation only)
- **Video generation:** ~8-10 minutes (depends on GPU speed)

## Output

Video demonstrating:
- The problem: Scattered journaling doesn't drive clarity
- The solution: Systematic AI-powered journaling dashboard
- The proof: 12-week transformation metrics
- The system: How it works end-to-end
- The features: Voice journaling, mood tracking, analytics, AI summaries
- The results: 4X deep work, 94% consistency, 60% less burnout
- The action: How to get started in 15 minutes

**Resolution:** 1280×720 (YouTube-ready)
**Duration:** ~4 minutes
**Format:** MP4 (H.264)

## What You Need

- Access to a machine with an NVIDIA GPU
- ~5GB free disk space
- Python 3.10+ installed

## Troubleshooting

**GPU not detected?**
```bash
nvidia-smi
```

**CUDA version mismatch?**
The script auto-selects CUDA 12.1. If you have a different version, modify the PyTorch installation line in `setup_and_generate.sh`.

**Out of GPU memory?**
Reduce `num_inference_steps` from 25 to 20 in the embedded `generate_video.py` script.

## More Info

For complete Personal Journaling System (features, setup, guides):
https://github.com/sriramshiv26-prog/personal-journaling

## Next Steps

1. **Clone this repo on your GPU machine**
2. **Run:** `bash setup_and_generate.sh`
3. **Download the video locally** (if running on remote GPU machine)
4. **Upload to YouTube** (unlisted for testing)
5. **Share in GitHub README** (link to video)
6. **Share on social media** (LinkedIn, Twitter, Dev.to)
