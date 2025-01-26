Automatic File Organisation
===========================

This script organises files in a directory into subfolders based on their extensions. It is designed to handle edge cases such as files without extensions, hidden files and uppercase file extensions.
This project builds upon my foundational knowledge of Bash scriping, adding some complexity and practical utility.

---

## Key Concepts Learned

### String Maniupulation
- Extracting file extensions and converting them to lowercase using parameter expansion and tools like `tr` 

### File and Directory Manipulation
- Using Bash commands such as `mkdir`, `mv` and conditionals to dynamically organise files into folders.

### Handling Edge Cases in File Operations
- Implementing logic to manage hidden files, files without extensions and files with uppercase extensions.

### User Input and Error Handling
- Preparing to allow user-specified directories and ensuring robustness with clear error messages.

### Writing Modular and Readable Code
- Structuring the script for clarity, reusability and maintainability.

---

## How to run the script

1. Clone this repository to your local machine:
```
git clone https://github.com/joshuavaughanpalmer/automatic-file-organisation.git
cd automatic-file-organisation
```

2. Make the script executable:
```
chmod +x automatic-file-organisation.sh
```

3. Run the script in the current directory:
```
./automatic-file-organisation.sh
```

4. (Optional) Specify a target directory as an argument:
```
./automatic-file-organisation.sh /path/to/directory
```

---

## Example Output

Given the following directory:
```
test_files/
|-- file1.txt
|-- file2.TXT
|-- image1.jpg
|-- .hidden
|-- README
|-- data.csv
|-- file.with.multiple.dots.tar.gz
```

After running the script:
```
test_files/
|-- text/
|	|-- file1.txt
|	|-- file2.txt
|-- jpg/
|	|-- image1.jpg
|-- csv/
|	|-- data.csv
|-- tar.gz/
|	|-- file.with.multiple.dots.tar.gz
|-- no-extension/
|	|-- .hidden
|	|-- README
```
---
