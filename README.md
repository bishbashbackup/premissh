# Premissh
A simple prototype tool for automatically creating PREMIS XML from a file, using DROID, BASH and XSLT. 

This script is very much a work in progress and I'm developing it to progress my own programming skills/knowledge. It currently has minimum functionality and doesn't actively check the input it's given. So, there a high risk for issues. I appreciate any feedback given, please flag any comments in the issues tracker.

This repository is provided as-is without any warranty or support. The author is not responsible for any damage or loss caused by the use of this script 


This documentation was last updated in 28th February 2024.

## Contents

1. [Introduction](#Introduction)
1. [Getting started](#Getting-Started)
   1. [Using BASH Terminal](#Using-BASH-Terminal)
   1. [Install Dependencies](#Install-Dependencies)
   1. [Download Repository](#Download-Repository)
   1. [Make Executable](#Make-Executable)
1. [Usage](#Usage)
1. [License](#License)


## Introduction

This repository contains a simple BASH script which can extract metadata from a digital file and outputs it as PREMIS XML. I created this as part of my MA Archives Records Management at UCL, for the INST0045 Digital Curation module. It is currently a working prototype.


## How it Works
The UK National Archives' file profiling tool (DROID) is used by the script to do most of the metadata extraction. This is also supplemented with further metadata provided by exiftool. DROID outputs metadata in a CSV format, which the BASH script converts to XML. An XSLT stylesheet applied to the XML, using Saxon, outputting the PREMIS XML document. DROID an Saxon are included within the repository, so you don't need to have these pre-installed.


## Getting Started
Premissh is a BASH script, so you have to use a compatible Unix-based shell program to run it. I used BASH to develop it, so I'd recommend using this.


### Using BASH Terminal

Ubuntu - You should be able to just use the pre-installed terminal application, as BASH comes installed as default.

Mac - I haven't tested Premissh on Mac desktop. It currently isn't compatible with the default terminal shell application (Zsh). However, it should work with a recent version of BASH. The installation instructions below are for Ubuntu or WSL, and use the apt package manager. However, this is not compatible with Mac, so homebrew (https://brew.sh/) should be used instead for installing dependencies. You'll also need to use homebrew install GNU-Coreutils, since this is not pre-installed on Mac. 

Windows - There are multiple ways to use BASH within windows. Linux operating systems can be run through virtual box. Alternatively, the Windows Substem for Linux (WSL) can be used, which provides an Ubuntu/BASH environment that can be accessed through powershell. Installation instructions for WSL can be found here: https://learn.microsoft.com/en-us/windows/wsl/install


### Install Dependencies

#### Install Java
`sudo apt install default-jre`


#### Install Exiftool
`sudo apt install exiftool`

#### Download and Extract DROID
https://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/

#### Download and Extract Saxon Home Edition
https://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/

#### Update config.txt
DROID and Saxon are standalone executable programs that do no require installation. You should move them to a permanent location on the filesystem. You'll then need to update the 'config.txt'. This contains variables, which let the bash script know where DROID and Saxon are located. Replace the filepaths in the file, with the absolute paths to the droid-command-line.jar file and the saxon-he.jar file. Further instructions are provided in the config.txt file.


### Download the Repository
`git clone https://github.com/bishbashbackup/premissh.git`


### Make Executable

To run the script, you need to give it executable permissions. This can be achieved with the following command, replacing "path/to/premissh.sh" with the actual filepath to the premissh.sh file. You can find this in the top level of the repository, downloaded in the previous step.

`sudo chmod +x "path/to/premissh.sh"`


## Usage 

To run the bash script you can use the following command. Replace "path/to/premissh.sh" with the filepath to the bash script file within the downloaded repository. Replace "path/to/target-folder" with the folderpath that contains the files you want to create Premis XML for. The Premis XML file will be outputted adjacent to the folder being processed. If your system complies with the bagit specification, you can give the folderpath to the bag's "data" folder. A single Premis document will be created, which will object entity for every file encountered within the folder.

`bash "path/to/premissh.sh"  "path/to/target-folder"`

If you are using WSL, then you need to give the absolute filepath from the Ubuntu root folder. If the target folder is located on the windows filesystem, you can navigate to it via the ubuntu /mnt folder, as shown in the example filepaths above. 


## Licenses

This repository is available under the BSD 3-Clause License. Further information about this license can be found in the `LICENSE` file at the top level of this repository.

