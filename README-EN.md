<div align="center"><img src="doc/logo.webp" alt="OncePower"></div>

<!-- markdownlint-disable MD033 -->
<p></p>
<p align="center"><a href="README.md" style="text-decoration:none;">简体中文</a> | English </p>
<!-- markdownlint-enable MD033 -->


**OncePower** is a desktop tool that combines **batch file renaming** and **file organization** into one. Users can perform advanced matching and modification of file names without learning regular expressions. The software was originally developed to batch rename images, so it has a special feature for images and videos - **View Mode** - to preview images and videos.

# Language and Platform Support

- **中文** (Chinese), **English**
- **Windows** (supports Windows 10 and above), **Linux**

# Quick Start

Table of Contents: [Basic Operations](#basic-operations), [Replace and Reserve Modes](#replace-and-reserve-modes), [CSV File Naming](#csv-file-naming), [Modify File Date](#modify-file-date), [Advance Mode](#advance-mode), [Organize Mode](#organize-mode)

> [!Tip]
>
> Due to the difficulty of recording GIFs, only dynamic diagrams in Chinese are available. If you do not understand, you can open the software and refer to the pictures to learn and use them

## Basic Operations

### Add Files

Add files via the button in the bottom left corner, or by dragging files directly into the software

![34](doc/34.gif)

### Add Folders

By default, when selecting a folder, only the files under the folder are added

![16](doc/16.gif)

When "Add Folder" is selected, if a folder is added, the folder itself is added

![17](doc/17.gif)

Add an icon button next to the folder to add subfolders within the folder (excluding the folder itself)

![18](doc/18.gif)

### Append Mode

If Append Mode is not selected, newly added files will replace the original files

![32](doc/32.gif)

If Append Mode is selected, the previous files will not be removed

![33](doc/33.gif)

### List Operations

You can quickly adjust the position of files by dragging list items

![35](doc/35.gif)

### Collapse Original Names

If you feel the original names are too wide, you can collapse the width of the original name display

![43](doc/43.gif)

### Export File Names

You can also export the names of files in the list. The exported format is CSV, with commas at the end

![44](doc/44.gif)

The exported file can be edited and then used to batch rename files by uploading the CSV file

### List Item Right-Click Menu

If there are many items in the list, you can quickly move to the beginning or end via the right-click menu

![36](doc/36.gif)

The right-click menu varies depending on the mode. You can experiment with each option yourself

### View Mode

Click the icon button at the bottom to enable image and video preview. This feature will remove other types of files

![21](doc/21.gif)

You can double-click to preview large images

![22](doc/22.gif)

### Multi-Select

You can use **Ctrl** and **Shift** with **left mouse button** to multi-select items in the list

![37](doc/37.gif)

Selected files will have serial numbers in the top left corner. You can quickly sort images by moving them via the right-click menu

![38](doc/38.gif)

### Stash Files

Since there is no feature to drag multiple files at once, a **stash feature** has been added

![39](doc/39.gif)

### Groups

Groups are only available in Advance Mode and Organize Mode

You can apply different naming effects to files in different groups via group mode

![40](doc/40.gif)

### Toggle Display List

By default, all files in the list are displayed. If you only want to show files with new names or without new names, you can toggle via left and right mouse buttons

![42](doc/42.gif)

### Change Image Display Size

If you are viewing preview images on a high-resolution screen and feel the images are too small, you can long-press the icon button in the top right corner of View Mode to change the width of the image display

![41](doc/41.gif)

### **Save Configuration**

By default, the software does not save any changes made by the user except for settings. When enabled, it can store the values of most input contents in each mode for direct use next time

![image-20260423100436944](doc/2.png)

### **System Right-Click Menu**

Click the right-click menu icon button at the bottom

![19](doc/19.gif)

When enabled, you can add files via the right-click menu in File Explorer

![20](doc/20.gif)

Due to Windows system limitations, only one file path can be passed at a time. This feature can only select folders when the program is not running. You can use it with the "Start on Boot" button next to it. Of course, if you want to pass multiple file or folder paths, you can place a shortcut to this software in the "Send To" folder, so you can also pass multiple files without starting the software.

### Save Logs

Click the Save Logs button at the bottom. When enabled, it will save data before and after renaming. The files will be saved in the logs folder under the software directory

![image-20260423100711239](doc/3.png)

## Replace and Reserve Modes

### Main Differences Between Replace and Reserve Modes

#### **Default State**

![1](doc/1.gif)

#### **Match Content**

![2](doc/2.gif)

When the button to the right of the match input box is lit, it becomes match length:

![5](doc/5.gif)

#### **Modify Content**

![3](doc/3.gif)

There is a date button in the modify input box. Clicking it will automatically fill in today's date. You can also use the up and down keys to adjust the date (the adjustment is for numbers, so 20260401 minus 1 becomes 20260400):

![4](doc/4.gif)

When the button to the right of the modify input box is lit, it becomes case-insensitive:

![6](doc/6.gif)

#### **Replace Mode Match Features**

![7](doc/7.gif)

#### Reserve Mode Match Features

![8](doc/8.gif)

### Date Naming

Click the rightmost button of the date item to rename using file date

![9](doc/9.gif)

### Prefix and Suffix

Via input

![10](doc/10.gif)

Via file upload

![11](doc/11.gif)

You can also directly edit the content uploaded from the file (this will not change the file itself)

![12](doc/12.gif)

The same operation applies to suffixes

### Sequence

![13](doc/13.gif)

The same operation applies to suffix sequences

### Extension

Batch modify file extensions

![14](doc/14.gif)

### Distinction Options

Add sequences by category

![15](doc/15.gif)

If using date naming, files with the same date will be added as a sequence group, and sequences will be added by file type and extension

## CSV File Naming

Click the Upload CSV File button at the bottom to upload CSV files, or TXT files in CSV format, or log files generated by this software to batch rename files

![23](doc/23.gif)

## Modify File Date

Click the Modify Date button at the bottom

![24](doc/24.gif)

If an interval value other than 0 is selected, the date will be incremented or decremented according to the file order

## Advance Mode

### Delete

#### Text

![25](doc/25.gif)

You can also delete the Nth matched value

![26](doc/26.gif)

You can also perform more detailed matching and deletion based on the following options

![image-20260422212114785](doc/1.png)

#### Type

You can also delete specific types without entering anything

![27](doc/27.gif)

#### Position

Delete content at a specified position

![28](doc/28.gif)

#### Extension

You can also delete file extensions

![29](doc/29.gif)

### Add

#### Text

![30](doc/30.gif)

#### Sequence

![31](doc/31.gif)

Advance Mode has more precise sequence control than Replace and Reserve modes

![image-20260423121142586](doc/4.png)

#### Random Number

![45](doc/45.gif)

#### Other

There are other types that can be added, which will not be demonstrated here

![image-20260423121725437](doc/5.png)

#### Add Position

There is also an option to add position at the bottom, which controls the position of the condition content through the number input box on the far right

![image-20260423121828306](doc/6.png)

The "After" and "Before" options will not be demonstrated here. Let's focus on the "End" and "Interval" options:

- **End**: The input content will be added to the end of the file extension. The value in the input box on the right does not affect the position added to the extension
- **Interval**: ![46](doc/46.gif)

### Replace

#### Normal

Same as Replace Mode, so it will not be demonstrated here. The only difference is that the two buttons on the right are used to match regular expressions and match extensions respectively

![image-20260423124211350](doc/7.png)

#### Convert

![47](doc/47.gif)

#### Format

When Format is selected, if the matched content is not a number, it will be converted to the length of each name

![48](doc/48.gif)

#### Word Interval

Automatically separate words. Due to technical limitations, separation can only be done via capitalization at the beginning

![49](doc/49.gif)

### Preset

You can store commonly used instruction groups as presets for easy use next time. You can also import and export stored presets. The preset list can be operated in batches via the right-click menu just like the file list, which will not be demonstrated here

![image-20260423125557893](doc/8.png)

## Organize Mode

Sometimes after renaming files, we need to move them to other folders. This is where Organize Mode comes in. It has the following move options:

- Default: Move all selected files to the **target folder**
- Group Name Classification: Set different folders for different groups via the **Set Group Folder** button
- Type Classification: Set different folders for different types of files via the **Set Type Folder** button
- Date Classification: Classify files by date and create folders named after dates
- Top Folder, Delete Selected Files, Delete Empty Folders have explanations in the software

![image-20260423125925490](doc/9.png)

# LICENSE

[GPL 3.0 License](./LICENSE)