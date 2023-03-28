# Codon docker
Setup Codon environment with Docker.

## Preparation
If necessary, open `Dockerfile` in an editor and modify `CODON_VERSION` to the latest version.

The relevant part is shown below.

```bash
ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=utf-8 \
    CODON_PYTHON=/usr/lib/libpython3.so \
    CODON_VERSION=0.15.5
```

The latest version can also be checked with the following command.

```bash
# In the case of using wget
wget -q https://github.com/exaloop/codon/releases/latest -O - | grep -oP "(?<=Release v)([0-9\.]+)\s" | uniq

# In the case of using curl
curl -fsSL https://github.com/exaloop/codon/releases/latest | grep -oP "(?<=Release v)([0-9\.]+)\s" | uniq
```

## Build
Execute the following command.

```bash
docker-compose build -no-cache
```

## Usage
Run the following commands to execute a example python script.

```bash
# In the host environment
docker exec -it codon bash

# In the docker environment
codon build --release estimate_pi.py
./estimate_pi
```
