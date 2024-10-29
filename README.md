# Flui 🦆🦠🧬

A text-based user interface for sub-typing avian influenza viruses using real-time [Nanopore][nanopore] reads.

![](tui.png)

## Installation

> NOTE: If you want to *develop*, rather than simply run `flui`, then see the section below for different installation instructions.

### 1. Ensure you have access to the `flui` package

The software is currently hosted on a private GitHub repo.
You will need access rights to this repository to get the software.

The simplest way to get access to the package is by downloading a zip file from the
[releases page](https://github.com/dragonfly-science/flui/releases).
This method also allows you to provide the package to others (via email, for example).

Alternatively, you can install the package directly from GitHub.
You will will need to generate an SSH key that you have uploaded to GitHub.
See instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

### 2. Install a package manager

`flui` is a python package, and there are many ways to install python programs.
Below, we show two ways to install the package that are easy and ensure a correct installation.

**Option 1: UV**

[uv](https://docs.astral.sh/uv/) is the simplest option,
as it also installs the python version required for you.
It will work on Windows, MacOS, and Unix.
Follow the installation instructions from the website (which differ depending on your platform).

Then do one of the following:

From a downloaded zip-file release (where x.x.x is the version downloaded):

```sh
uv tool install --from /path/to/zipfile/flui-x.x.x.zip flui
```

Directly from Github:

```sh
uv tool install --from git+ssh://git@github.com/dragonfly-science/flui.git@main flui
```

You should now be able to run `flui --help`

**Option 2: Pipx**

[Pipx](https://pipx.pypa.io/stable/) may be suitable for older systems (such as NESI, at the moment).
It requires the correct version of python (3.11) to be pre-installed.
Here is how to install the application using `pipx` on `NESI` (as of October 2024).

Activate python 3.11 and install pipx.

```sh
module load Python/3.11.6-foss-2023a
pip install pipx
```

Then use pipx to install the application (force overwrites any previous version).
From a download:

```sh
pipx install /path/to/download/flui-x.x.x.zip --force
```

Or from Github:

```sh
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
Simply press the “h” button after starting the application.
You can also read it here: [help](src/flui/help.md).

## Development

For development, you’ll need to install the following dependencies:

* [uv](https://docs.astral.sh/uv/)
* [just](https://github.com/casey/just)

Once `uv` is installed, you can use it to install some additional tools:

```sh
uv tool install ruff
uv tool install pyright
```

The `just` tool is used to run development-related tasks.
The `check` command runs all linting and tests, for example:

```sh
just check
```

At this stage, generating releases is not automated.

[nanopore]: <https://nanoporetech.com/platform/technology>
