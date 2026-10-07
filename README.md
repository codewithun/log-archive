# Log Archive Tool

A simple Bash CLI tool for archiving log files by compressing them into a `.tar.gz` file.

This project was created as part of the [roadmap.sh Log Archive Tool project](https://roadmap.sh/projects/log-archive-tool).

## Features

* Accepts a log directory as a command-line argument
* Validates the provided directory
* Compresses logs into a `.tar.gz` archive
* Automatically generates a timestamped archive filename
* Stores archives in a dedicated `archive` directory
* Records archive activity and timestamp in a log file
* Provides clear command-line output
* Uses standard Unix/Linux commands

## Requirements

* Linux or Unix-based operating system
* Bash
* `tar`
* `date`
* `mkdir`
* `dirname`
* `basename`

## Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/log-archive.git
```

Navigate into the project:

```bash
cd log-archive
```

Make the script executable:

```bash
chmod +x log-archive
```

## Usage

Run the tool by providing a log directory:

```bash
./log-archive <log-directory>
```

Example:

```bash
./log-archive /var/log
```

For testing with a custom directory:

```bash
./log-archive test-logs
```

## Example

Suppose the following directory exists:

```text
test-logs/
├── app.log
├── auth.log
└── database.log
```

Run:

```bash
./log-archive test-logs
```

The tool creates:

```text
archive/
├── logs_archive_20261007_183025.tar.gz
└── archive.log
```

The archive filename contains the date and time when the archive was created.

Example:

```text
logs_archive_20261007_183025.tar.gz
```

## Archive Log

Every successful archive operation is recorded in:

```text
archive/archive.log
```

Example:

```text
[2026-10-07 18:30:25] Archived 'test-logs' -> './archive/logs_archive_20261007_183025.tar.gz'
```

## Commands Used

### `tar`

Used to create and compress the archive.

```bash
tar -czf archive.tar.gz directory
```

Options:

* `-c` — create a new archive
* `-z` — compress using gzip
* `-f` — specify the archive filename

### `date`

Used to generate timestamps:

```bash
date +"%Y%m%d_%H%M%S"
```

Example:

```text
20261007_183025
```

### `mkdir`

Creates the archive directory:

```bash
mkdir -p archive
```

The `-p` option allows the command to create the directory if it does not already exist.

### `dirname`

Returns the parent directory of a path:

```bash
dirname /var/log
```

Result:

```text
/var
```

### `basename`

Returns the final component of a path:

```bash
basename /var/log
```

Result:

```text
log
```

These commands are used together to create an archive without storing the original absolute path.

### `echo`

Used to display information and append archive records to the log file:

```bash
echo "Archive created"
```

### `>>`

Appends output to a file without overwriting existing content:

```bash
echo "Archive completed" >> archive.log
```

## Project Structure

```text
log-archive/
├── log-archive
├── README.md
├── .gitignore
└── archive/
    └── archive.log
```

The `archive/` directory is generated automatically when the script runs.

## Testing

Create a test directory:

```bash
mkdir -p test-logs
```

Create sample log files:

```bash
echo "Application started" > test-logs/app.log
echo "User logged in" > test-logs/auth.log
echo "Database connection successful" > test-logs/database.log
```

Run the tool:

```bash
./log-archive test-logs
```

Check the generated archive:

```bash
ls -lh archive/
```

List the contents of the archive:

```bash
tar -tzf archive/logs_archive_YYYYMMDD_HHMMSS.tar.gz
```

## Learning Goals

This project helps practice:

* Bash scripting
* Command-line arguments
* File and directory operations
* File compression
* `tar` archives
* Timestamp generation
* Input validation
* Logging
* Linux/Unix command-line tools

## Roadmap.sh

Project reference:

https://roadmap.sh/projects/log-archive-tool

## License

This project is open source and available for learning purposes.
