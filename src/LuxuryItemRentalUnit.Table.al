table 50207 "Luxury Item Rental Unit"
{
    DataClassification = ToBeClassified;
    Caption = 'Luxury Item Rental Unit';

    fields
    {
        field(1; "Luxury Item No."; Code[20])
        {
            Caption = 'Luxury Item No.';
            NotBlank = true;
            TableRelation = "Luxury Item";
        }
        field(2; "LI Unit No."; Code[20]) //CTRL + K C
        {
            Caption = 'LI Unit No.';
            NotBlank = true;

            trigger OnValidate()
            var
                LuxuryItem: Record "Luxury Item";
                LIClass: Record "Luxury clothing Class";
            begin
                if Rec."Luxury Item No." = '' then
                    exit;
                LuxuryItem.Get("Luxury Item No.");
                LuxuryItem.TestField("Luxury Item Category Code"); // testib kas väli on täidetud (kohustuslikust testib)
                LIClass.Get(LuxuryItem."Luxury Item Category Code");
                LIClass.TestField("Default Renting Location Code");


                // Rec."LI Location Code" := LIClass."Default LI Location Code";
                Rec.Validate("LI Location Code", LIClass."Default Renting Location Code");
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "LI Location Code"; Code[10])
        {
            Caption = 'LI Location Code';
            DataClassification = CustomerContent; // Võib olla, aga ei pea
            TableRelation = "Item Location";
        }
        field(5; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(6; "Serial No."; Text[50])
        {
            Caption = 'Serial No.';
            NotBlank = true;
            TableRelation = "Serial No. Information";
        }
    }

    keys
    {
        key(Key1; "Luxury Item No.", "LI Unit No.")
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