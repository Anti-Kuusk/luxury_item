table 50201 "Item Location"
{
    DataClassification = ToBeClassified;
    Caption = 'Item Location';
    LookupPageID = "Item Locations";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Location Code';
            NotBlank = true;
        }
        field(2; "Rental Item Location Nos"; Text[50])
        {
            Caption = 'Location name';
            NotBlank = true;

        }
        field(3; "Address"; Text[250])
        {
            Caption = 'Address';
            NotBlank = true;

        }
        field(4; "City"; Text[250])
        {
            Caption = 'City';
            NotBlank = true;

        }

    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    var
    // myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}
