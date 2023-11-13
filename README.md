# export_generator

The `export_generator` package simplifies the process of exporting all files in a directory hierarchy by automatically creating an export configuration file. The primary purpose is to identify and remove individual imports, generating a single configuration file that exports everything within the specified directory.

## Installation

Add `export_generator` to your `pubspec.yaml` file:

```yaml
dependencies:
  export_generator: ^1.0.0  # Use the latest version
Then run:
    dart pub get
