# Flui 🦆🦠🧬

A text-based user interface for sub-typing avian influenza viruses using real-time [Nanopore][nanopore] reads.

![](tui.png)

## Installation

### 1. Install a package manager

The recommended way to install `flui` is via a program that manages python packages.
Two choices are available.
Please choose one, and follow the installation instructions are on the website before proceeding.

* [uv](https://docs.astral.sh/uv/): A modern package manager.
  This is the best choice (if possible), as it is also used for package development.
* [pipx](https://pipx.pypa.io/stable/): An older option, which may work better on older systems (NESI).

### 2. Enable access to the repository

The package is currently, private.
Thus, you will need to generate an SSH key and add it to your GitHub account.
See instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

### 3. Install the application

Once `uv` or `pipx` is installed, you can install the application using the following command.
We use the `--force` option to overwrite any previous versions that have been installed.

```sh
uv install git+ssh://git@github.com/dragonfly-science/avian-flu.git@main --force
```

Here is how to install the application using `pipx` on `NESI` (as of October 2024).

```sh
module load Python/3.11.6-foss-2023a
pipx install git+ssh://git@github.com/dragonfly-science/avian-flu.git@main --force
```

## Usage

To see how to launch the UI, type `flui --help` into the terminal and press enter.
This will show the options available to you.
The two key things to provide are:

* `--run`: The path to a parent directory of the FastQ files. This should contain one or more runs, each containing multiple barcode sub-folders.
* `--ref`: This contains the reference genomes of HA and NA segments from different subtypes.

Typically, you will want to run a command like this:

```sh
flui --ref ref.fasta --run /path/to/fastq/files
```

Once you have started the application, you can navigate around using the arrow keys and tab keys.
Detailed help about all is available inside the `flui` application.
Simply press the "h" button after starting the application.
You can also read it here: [help](src/flui/help.md).

## Development

For development, you'll need to install the following dependencies:

* [uv](https://docs.astral.sh/uv/)
* [just](https://github.com/casey/just)

Once `uv` is installed, you can use it to install some additional tools:

```sh
uv tool install ruff
uv tool install pyright
```

The `just` tool is used to run development-related tasks:

```sh
just test
just lint
```

[nanopore]: <https://nanoporetech.com/platform/technology>
