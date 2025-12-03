# Docker Setup for VariantTransformer

This Docker container provides a complete environment for running VariantTransformer with all dependencies pre-installed.

## Prerequisites

- Docker installed on your system
- (Optional) Docker Compose for easier management

## Quick Start

### Option 1: Using Docker Compose (Recommended)

```bash
# Build and run the container
docker-compose up -d

# View logs
docker-compose logs -f

# Access Jupyter at http://localhost:8888
```

### Option 2: Using Docker directly

```bash
# Build the image
docker build -t varianttransformer .

# Run the container
docker run -d \
  -p 8888:8888 \
  -v $(pwd):/app \
  --name varianttransformer \
  varianttransformer

# Access Jupyter at http://localhost:8888
```

## Container Contents

The Docker container includes:

### System Dependencies
- `tabix` - Tabix indexing tool
- `vcftools` - VCF file manipulation tools
- `bcftools` - BCF/VCF manipulation and analysis tools

### Python Packages
- `pyvcf` - VCF file parser for Python
- `pytabix` - Python interface to tabix
- `transformers` - Hugging Face Transformers library
- `torch` - PyTorch deep learning framework
- `pandas` - Data manipulation and analysis
- `numpy` - Numerical computing
- `scikit-learn` - Machine learning utilities
- `jupyter` - Jupyter notebook environment

## Usage

### Running Jupyter Notebooks

The container starts a Jupyter notebook server by default. Access it at:
- **URL**: http://localhost:8888
- **No password required** (for development - change in production)

### Running Python Scripts

```bash
# Execute a Python script
docker exec varianttransformer python /app/training_and_validation/find_unique_words.py

# Interactive Python shell
docker exec -it varianttransformer python
```

### Using VCF Tools

```bash
# Access bcftools
docker exec varianttransformer bcftools --version

# Access vcftools
docker exec varianttransformer vcf-concat --help
```

## Volume Mounts

The container mounts your local project directory to `/app` in the container, so:
- Changes to files are reflected immediately
- Data files can be accessed from both host and container
- Notebooks can be edited and run seamlessly

## Building for Production

For production use, you may want to:

1. **Add authentication** to Jupyter:
   ```dockerfile
   # Generate password hash: jupyter notebook password
   ENV JUPYTER_PASSWORD_HASH="your_hash_here"
   ```

2. **Use specific versions** of packages in requirements.txt

3. **Optimize image size** by using multi-stage builds

## Troubleshooting

### Port Already in Use
```bash
# Use a different port
docker run -p 8889:8888 varianttransformer
```

### Permission Issues
```bash
# Run with user permissions
docker run -u $(id -u):$(id -g) -p 8888:8888 varianttransformer
```

### View Container Logs
```bash
docker logs varianttransformer
```

### Stop and Remove Container
```bash
# Using docker-compose
docker-compose down

# Using docker
docker stop varianttransformer
docker rm varianttransformer
```

## Development Workflow

1. Make changes to your code locally
2. Changes are automatically reflected in the container (via volume mount)
3. Run notebooks or scripts in the container
4. Results are saved to your local filesystem

## Notes

- The container runs as root by default (for Jupyter)
- Large VCF files should be placed in the project directory or mounted volumes
- GPU support requires additional Docker configuration (nvidia-docker)

