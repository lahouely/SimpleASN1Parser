## Known Limits/Issues

- This parser doesn't support:
  - Non-breaking space characters in the modules files.
  - Non-breaking hyphen characters in the modules files.
  - XML binary strings.
  - XML hexadecimal strings.
  - XML character strings.
  - Time value character strings.
  - XML time value character strings.
  - Non-integer Unicode labels.
  - XML end tag start item.
  - XML single tag end item.
  - XML boolean true item.
  - XML boolean extended-true item.
  - XML boolean false item.
  - XML boolean extended-false item.
  - XML real not-a-number item.
  - XML real infinity item.
  - XML tag names for ASN.1 types.
  


- Not yet implemented:
  - Multiline "Character strings", only single line "Character strings" are implemented.
  - Handling for double quotes within "Character strings".
  - Single quotation character lexical item may need a review. ISO/IEC 8824-1:2021 (E) 12.37