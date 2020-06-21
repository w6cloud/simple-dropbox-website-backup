# Simple DropBox website backup

Simple bash script that creates an archive containing website files and databade dump.
This archive is than uploaded to DropBox.

## Installation

Rename `src/config.sample.sh` and configure it to your needs.

## Usage

Execute `src/backup.sh` and wait for the backup to finish !

## Cron

Cron task example to backup website everyday at 03 h 05 m :

```bash
5 3 * * * /full/path/to/backup.sh
```

## DropBox tips

To keep backups history activate "Versions history" on DropBox.
