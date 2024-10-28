
# Flui Help

This application analyses FastQ files from a Nanopore sequencer. i
It produces kmer distributions from the reads to determine the subtype of the Avian Flu virus present in each sample.
If the kmer distributions match closely enough, the app will assign a subtype for the HA and NA segments.
Whether this gets assigned depends on three thresholds:

* There must be a minimum number of kmers found (to avoid premature matching).
* The matching score to particular subtype must be high enough (to ensure the match is good).
* The matching score must be sufficiently bigger than the next biggest match (to ensure the match is not ambiguous).

## Locating the FastQ Files

There are two ways that that the app discovers FastQ files to process. When you start the application, you provide it with a parent folder and it will process:

1. **Pre-existing FastQ Files**: Any FASTQ files in sub-folders (however deep) that match the Nanopore naming conventions. These will be processed in random order.
2. **Incoming FastQ Files**: While the application is running
     the app will monitor any subfolders for new FASTQ files that are placed there (assumedly, by the Nanopore software as it processes the reads). These will be processed in the order they arrive.

Each time a new FASTQ file for a particular barcode is processed, the scores and reads for that barcode are updated. This happens in the background, so the effect may not be immediately seen.

## User Interface

The interface contains a number of panes:

* Main Pane: Each row has run/barcode on it, and the columns show the current status of that particular barcode.
* NA and HA Windows (on the right): This shows the detail associated with the currently highlighted row in the main panel.
    Red writing shows which thresholds have not been met; green writing shows which thresholds are passed.
* Events Window (bottom): This shows any new FASTQ files that are found, or processed, and which barcodes are being updated.
* Settings Window (bottom right): This shows the thresholds that are currently set (from the settings file, or the command-line, or the defaults).

### Interactions

* The tab key and arrow keys allow you to move around the interface.
* Columns can be sorted by clicking on the column header, or by using the shortcut keys shown at the bottom of the screen.

## Configuration

The Flui applications has a number of settings that can be changed, either at startup, or in a settings file.
The settings file must be called `flui.toml` and stored in the working directory.
Here you can set the kmer sizes, and the number of workers, and some UI color options.
See the github repository for an [example file](https://github.com/dragonfly-science/flui/blob/main/flui.toml).
Some settings can also be set on the command line (use `flui --help` to see these).

## Scoring and Subtype Assignment

This is how we produce the scores and automatic subtyping.

1. The app is started with a `--ref` argument that points to a FASTA file.
    This FASTA file contains the reference sequences for the different subtypes.
    These sequences have both the subtype and segment number or type in the sequence header (i.e. HA/H1N1).
    We only use the HA and NA segments for subtyping (others are ignored).
2. The app reads the FASTA file and, for each segment/subtype combination, it produces a kmer distribution.
    Each kmer distribution captures the kmer frequencies for each segment/subtype.
    These distributions are stored in memory.
3. The app reads in any FastQ files and, for each read, it also produces a kmer distribution.
    These kmer distributions are per run/barcode (we get this information from the file name).
    As more reads come in, we update the distribution for that run/barcode.
4. For each barcode distribution, we compare it to our set of reference distributions,
    and measure the _Jensen-Shannon Distance_ (JSD) to each references distribution. (The JSD is the square root of the [Jensen-Shannon Divergence](https://en.wikipedia.org/wiki/Jensen%E2%80%93Shannon_divergence)).
    The more the kmer distributions resemble each other, the lower the JSD.
5. We transform this measure, to make it easier to interpret. First we normalize it by dividing by the average JSD between all reference distributions. This produces the JSDN. Good matches will have JSDN values that fall below 1.0 (i.e. they are small than the distances between the references). To make this easier to interpret, we then take the complement of this value and multiply by 100: Matching Score = (1 - JSDN) * 100.
6. This score is thus a _percentage reduction from expected kmer distribution distance_. Bigger values are better. Empirical tests show values of around six and above as typical for a good match.
