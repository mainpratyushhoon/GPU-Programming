<div id="top"></div>

<!-- PROJECT SHIELDS -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links-->
<div align="center">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

</div>

<!-- PROJECT LOGO -->
<br />
<!-- UPDATE -->
<div align="center">
  <a href="https://github.com/mainpratyushhoon/GPU-Programming.git">
     <img width="140" alt="image" src="https://miro.medium.com/v2/resize:fit:4800/format:webp/0*YUYbEi-N4dOC7KtM.jpg">
  </a>

  <h3 align="center">GPU-Programming</h3>

  <p align="center">
  <!-- UPDATE -->
    <i>Go faster with GPUs</i>
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
<summary>Table of Contents</summary>

- [About The Project](#about-the-project)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contact](#contact)
  - [Maintainer(s)](#maintainers)
  - [creators(s)](#creators)
- [Additional documentation](#additional-documentation)

</details>


<!-- ABOUT THE PROJECT -->
## About The Project
<!-- UPDATE -->
<div align="center">
  <a href="https://github.com/mainpratyushhoon/GPU-Programming.git">
    <img width="50%" alt="image" src="https://github.com/mainpratyushhoon/GPU-Programming/blob/main/Image/Figure_1.png">
  </a>
</div>

_This project implements and compares matrix multiplication on CPU and GPU using NVIDIA's CUDA programming model. The goal is to demonstrate the performance gain achieved through parallel computation and to validate the correctness of GPU computation against a traditional CPU-based approach._

<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started

To set up a local instance of the application, follow the steps below.

### Prerequisites
The following dependencies are required to be installed for the project to function properly:<br>
1. Go to <a href="https://developer.nvidia.com/cuda-downloads"> NVIDIA CUDA ToolKit </a> <br>
2. Choose:
    - OS: Windows
    - Version: Your Windows version (e.g., 10 or 11)
    - Installer Type: Network Installer (recommended)
3. Download and Run the installer.
<!-- UPDATE -->
* Verify Installation:
  
  ```sh
  nvcc --version
  ```

<p align="right">(<a href="#top">back to top</a>)</p>

### Installation

_Now that the environment has been set up and configured to properly compile and run the project, the next step is to install and configure the project locally on your system._
<!-- UPDATE -->
1. Clone the repository

   ```sh
   git clone https://github.com/mainpratyushhoon/GPU-Programming.git
   ```
3. Execute the script

   ```sh
   ./main.exe
   ```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage
<!-- UPDATE -->
This project performs matrix multiplication of two square matrices (A × B = C), comparing performance between:
  - CPU (sequential)
  - GPU using CUDA (parallel)

### It helps evaluate:
  - Speed improvements using GPU parallelism
  - Accuracy of GPU computations vs CPU
  - Real-world performance scaling with matrix size

### When to Use It
You can use this project to:
  - Learn how to write CUDA kernels
  - Benchmark CPU vs GPU computation
  - Demonstrate parallel computing concepts

<div align="center">
  <a href="https://github.com/mainpratyushhoon/GPU-Programming.git">
    <img width="45%" align="center" alt="image" src="https://github.com/mainpratyushhoon/GPU-Programming/blob/main/Image/Figure_detail.png">
    <img width="45%" align="left" alt="image" src="https://github.com/mainpratyushhoon/GPU-Programming/blob/main/Image/ThroughPut.png">
  </a>
</div>
<br />
To produce more such graphs, use:

```sh
./main.exe
```
then,

 ```sh
python graph.py
   ```
```sh
python throughput.py
   ```
<p align="right">(<a href="#top">back to top</a>)</p>
<br>

## Contact

### Maintainer(s)

The currently active maintainer(s) of this project.

<!-- UPDATE -->
- [Pratyush Raj](https://github.com/mainpratyushhoon)

### Creator(s)

Honoring the original creator(s) and ideator(s) of this project.

<!-- UPDATE -->
- [Pratyush Raj](https://github.com/mainpratyushhoon)

<p align="right">(<a href="#top">back to top</a>)</p>

## Additional documentation

  - [License](/LICENSE)
  - [Code of Conduct](/.github/CODE_OF_CONDUCT.md)
  - [Security Policy](/.github/SECURITY.md)
  - [Contribution Guidelines](/.github/CONTRIBUTING.md)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/mainpratyushhoon/GPU-Programming.svg?style=for-the-badge
[contributors-url]: https://github.com/mainpratyushhoon/GPU-Programming/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/mainpratyushhoon/GPU-Programming.svg?style=for-the-badge
[forks-url]: https://github.com/mainpratyushhoon/GPU-Programming/network/members
[stars-shield]: https://img.shields.io/github/stars/mainpratyushhoon/GPU-Programming.svg?style=for-the-badge
[stars-url]: https://github.com/mainpratyushhoon/GPU-Programming/stargazers
[issues-shield]: https://img.shields.io/github/issues/mainpratyushhoon/GPU-Programming.svg?style=for-the-badge
[issues-url]: https://github.com/mainpratyushhoon/GPU-Programming/issues
[license-shield]: https://img.shields.io/github/license/mainpratyushhoon/GPU-Programming.svg?style=for-the-badge
[license-url]: https://github.com/mainpratyushhoon/GPU-Programming/blob/master/LICENSE
