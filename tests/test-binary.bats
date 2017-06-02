#!/usr/bin/env bats

# this is a basic bats test script (https://github.com/sstephenson/bats)
# the goal here is to check for output formatting errors and basic option
# handling bugs, not to rigorously test the grammar parser via the command line

@test "decimal addition" {
    result="$(radix-calc 5+5)"
    [[ "$result" = "10" ]]
}

@test "hexadecimal output" {
    result="$(radix-calc --hex '5*5')"
    [[ "$result" = "0x19" ]]
}

@test "octal output" {
    result="$(radix-calc --oct '5*5')"
    [[ "$result" = "0o31" ]]
}

@test "binary output" {
    result="$(radix-calc --bin '5*5')"
    [[ "$result" = "0b11001" ]]
}

@test "--all output" {
    result="$(radix-calc --all '5*5')"
    expected="25
0x19
0o31
0b11001"
    [[ "$result" = "$expected" ]]
}

@test "--alfred2 output" {
    result="$(radix-calc --alfred2 '5*5')"
    expected="<?xml version=\"1.0\"?>
<items>
  <item arg=\"25\" valid=\"YES\" autocomplete=\"25\" type=\"default\">
    <title>25</title>
    <subtitle>(decimal)</subtitle>
    <icon>dec.png</icon>
  </item>
  <item arg=\"0x19\" valid=\"YES\" autocomplete=\"0x19\" type=\"default\">
    <title>0x19</title>
    <subtitle>(hexadecimal)</subtitle>
    <icon>hex.png</icon>
  </item>
  <item arg=\"0o31\" valid=\"YES\" autocomplete=\"0o31\" type=\"default\">
    <title>0o31</title>
    <subtitle>(octal)</subtitle>
    <icon>oct.png</icon>
  </item>
  <item arg=\"0b11001\" valid=\"YES\" autocomplete=\"0b11001\" type=\"default\">
    <title>0b11001</title>
    <subtitle>(binary)</subtitle>
    <icon>bin.png</icon>
  </item>
</items>"
    [[ "$result" = "$expected" ]]
}

# vim: set ft=sh :
