# Numerate

## Description
This project is based on FinalRecon.py. I rewrote it in Nim as a learning exercise to better understand its structure and functionality. The goal was to improve my knowledge of both Nim and the original tool's inner workings.

Feel free to explore and contribute!

## Usage
To run this script, you can use the following commands:

1. Make sure you have Nim and compile it
    ```bash
    nim c -d:release -d:opt -d:ssl -o Nimurate main.nim
    ```

2. Execute the script:
    ```bash
    ./Nimurate -[f|co|h|e|c] -t https://exemple.com
    ```

3. Alternatively, you can redirect the output to a file:
    ```bash
    ./Nimurate -[f|co|h|e|c] -t https://exemple.com > nimurate.txt
    ```

## Disclaimer
This script is provided for educational purposes only. Use of this script for testing, either on your own systems or on systems for which you have legal authorization to perform such tests, is highly encouraged. However, executing this script on systems without such authorization is illegal and strictly forbidden. The creator of this script assumes no liability for misuse of this tool or any damage that might be caused by its appropriate or inappropriate use. It is the end user's responsibility to comply with all applicable local, state, and federal laws. Users must consider the impact of any actions they perform and be mindful of the applicable laws and rights of others.

By running this script, you agree to the terms of use and acknowledge that you have the necessary authorizations to perform such assessments.

## License
This project is licensed under the MIT License.

## Contributing
If you would like to contribute to this project, please fork the repository and create a pull request with your changes. We welcome improvements and suggestions.

## Contact
For any questions or issues, please open an issue in this repository or contact the maintainer.


