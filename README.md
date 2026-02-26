# Runtime-Anomaly-Testing-Using-AI
This project automates fault injection into a custom Linux kernel within QEMU across 1, 2, and 4-core setups. By triggering six distinct stress conditions, it generates a robust dataset of ~6,000 system telemetry logs. This data is then used to train a machine learning model to accurately classify and detect specific kernel fault states.

# Linux Kernel Fault Detection & Telemetry via QEMU

This project automates fault injection into a custom Linux kernel using QEMU. It collects system telemetry across multiple CPU configurations to build a dataset of approximately 6,000 system logs. This data is subsequently used to train a machine learning model to classify and detect specific kernel fault states.

## Project Scope & Dataset

The system systematically tests the custom kernel across three CPU configurations (1-core, 2-core, and 4-core). The automated processes generate hundreds of logs for each hardware configuration, resulting in a primary telemetry dataset of approximately 6,000 raw logs overall. This data is aggregated into CSV format for machine learning ingestion.

| Experiment ID | Fault Type | Description |
| :--- | :--- | :--- |
| EXP-1 | Normal | Baseline system telemetry with no injected stress. |
| EXP-2 | CPU Saturation | Heavy computational load to maximize CPU utilization. |
| EXP-3 | Interrupt Stress | High frequency of system interrupts to test handler efficiency. |
| EXP-4 | Memory Pressure | Rapid memory allocation/deallocation to trigger swapping and OOM. |
| EXP-5 | Mixed Stress | Simultaneous application of CPU, Memory, and I/O stress. |
| EXP-6 | True Interrupt Storm | Extreme hardware/software interrupt flooding. |

## Repository Structure

* `automated_running/`: Automation bash scripts tailored to trigger each specific experiment's fault condition.
* `backups/`: Contains the custom initialization scripts (e.g., `init_exp3.backup`) required for each experiment.
* `datasets/`: Aggregated and processed CSV datasets ready for model training.
* `logs/`: Raw telemetry logs categorized by experiment and CPU count (archived due to volume).
* `model.ipynb`: Jupyter Notebook containing the data preprocessing and machine learning model implementation.
* `run-qemu.sh`: Main entry script to boot the custom kernel environment in QEMU.

## Execution Instructions

Each experiment requires a specific boot-time environment. The initial RAM filesystem (`initramfs.gz`) must be configured and rebuilt prior to running a new experiment.

### 1. Prepare the Initialization Script
Navigate to the `backups/` directory, copy the specific initialization script for the target experiment, and replace the active kernel's `init` file.
Example for Experiment 3:
```bash
cp backups/exp3/init_exp3.backup path/to/your/sys/init

```

### 2. Rebuild the Filesystem

Following the script replacement, repackage the `initramfs.gz` archive to ensure the kernel boots with the updated instructions. Use your standard `cpio` and `gzip` build sequence to generate the new file.

### 3. Boot the Environment

Initialize the QEMU virtual machine using the root run script. Configure the script for the desired CPU topology (1, 2, or 4 cores) as necessary.

```bash
./run-qemu.sh

```

### 4. Automate Fault Injection

Once the QEMU environment is active and the custom initialization script has prepared the system, execute the corresponding automation script from the `automated_running` directory to inject the fault and initiate logging.
Example for Experiment 3:

```bash
./automated_running/automate_exp3.sh

```

## Machine Learning Analysis

Model training and evaluation are handled via the provided Jupyter Notebook.

1. Open `model.ipynb` in a Jupyter environment.
2. Ensure the data loader is pointed to `dataset_modified.csv` located within the `datasets/` directory.
3. Execute the notebook cells to preprocess the data, train the classifier, and output the validation accuracy for the fault states.

## Authors
Sarvesh Sakthivel 

Sriram Prasanna
