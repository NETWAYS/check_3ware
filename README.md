# check\_3ware

A collection of perl plugins to query 3ware raid controllers with the tw\_cli tool.


# Options

## check\_3ware.pl

Flag             | Description
-----------------|-----------------------
`--help`         | Plugin help.
`--usage`        | Short usage information.
`--controller`   | Controller ID.
`--unit`         | Unit ID.
`--warnings`     | Display warning keywords.
`--okays`        | Display ok keywords.
`--version`      | Print version.

## check\_dpti.pl

Flag             | Description
-----------------|-----------------------
`--help`         | Plugin help.
`--usage`        | Short usage information.
`--controller`   | Controller ID.



# Usage

```
check_3ware.pl -C 0 -U 0 (checks Controller 0 Unit 0 for status)
check_3ware.pl -W (Displays all Warning keywords)
check_3ware.pl -O (Displays all OK keywords)

check_dpti.pl -C 0  (checks Controller 0)
```
