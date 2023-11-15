# export_generator

The `export_generator` package streamlines the task of exporting all files in a directory hierarchy by automating the creation of an export configuration file. Its main function is to recognize and eliminate individual imports, generating a singular configuration file that exports all contents within the specified directory.

## Installation

To integrate `export_generator` into your project, follow these steps:

1. Add `export_generator` to your `pubspec.yaml` file:

    ```yaml
    dependencies:
      export_generator: ^1.0.0  # Use the latest version
    ```

2. Run the following command to fetch the package:

    ```bash
    dart pub get
    ```

## Usage

To utilize `export_generator` and export all files in a specific directory, run the following command:
Replace package_name with your package name

```bash
dart run export_generator ./lib/ -p "package_name"
