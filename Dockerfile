# VariantTransformer Docker Container
# Based on dependencies.txt requirements

FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    tabix \
    vcftools \
    bcftools \
    build-essential \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    pyvcf \
    pytabix \
    transformers \
    torch \
    pandas \
    numpy \
    scikit-learn \
    jupyter \
    notebook \
    ipykernel

# Copy project files
COPY . /app

# Set environment variables
ENV PYTHONPATH=/app
ENV PATH="/app:${PATH}"

# Expose Jupyter port
EXPOSE 8888

# Default command - start Jupyter notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

