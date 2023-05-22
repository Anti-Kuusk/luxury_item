table 50209 "Rental Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'RentalSetup';
    LookupPageId = "Rental Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Rental Item Nos"; Code[20])
        {
            Caption = 'Luxury Item Nos';
            TableRelation = "No. Series";
        }
        field(3; "Rental Order Nos."; Code[20])
        {
            Caption = 'Luxury Order Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
    //myInt: Integer;

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
