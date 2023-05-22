table 50217 "Rental Journal Line"
{
    //DataClassification = ToBeClassified;
    caption = 'Rental Journal Line';

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';

        }
        field(2; "Entry Type"; Enum "Rental Ledger Entry Type")
        {
            Caption = 'Entry Type';
        }
        field(3; "Document No."; code[20])
        {
            Caption = 'Document No.';

        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting date';
        }
        field(10; "Rental Order No."; code[20])
        {
            Caption = 'Rental Order No.';
            TableRelation = "Luxury Item Rental Order"."No.";

            trigger OnValidate()
            var
                RentalOrder: Record "Luxury Item Rental Order";

            begin
                if "Rental Order No." <> '' then begin
                    RentalOrder.Get("Rental Order No.");
                    "Customer No." := RentalOrder."Customer No.";
                    "Luxury Rental Item No." := RentalOrder."Rental Item No.";
                    "Luxury Item Rental Unit No." := RentalOrder."Rental Item Unit No.";                

                    "Rental Start" := RentalOrder."Rental Start";
                    "Rental End" := RentalOrder."Rental End";
                    "Rental Days" := RentalOrder."Rental Days";

                end;

            end;
        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(12; "Luxury Rental Item No."; Code[20])
        {
            Caption = 'Luxury Rental Item No.';
            TableRelation = "Luxury Item"."No.";
        }
        field(13; "Luxury Item Rental Unit No."; code[20])
        {
            Caption = 'Luxury Item Rental Unit No.';
            TableRelation = "Luxury Item Rental Unit"."LI Unit No." where("Luxury Item No." = field("Luxury Rental Item No."));

        }
        field(15; "Rental Start"; Date)
        {
            Caption = 'Rental Start';
            trigger OnValidate()
            begin

                if ("Rental Start" <> 0D) and ("Rental End" <> 0D) then //0D on tühi kuupäev, ehk määramata kp
                    "Rental Days" := "Rental End" - "Rental Start";

            end;
        }
        field(16; "Rental End"; Date)
        {
            Caption = 'Rental End';
            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental End" <> 0D) then
                    "Rental Days" := "Rental End" - "Rental Start";

            end;
        }
        field(17; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';
            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental Days" <> 0) then
                    "Rental End" := "Rental Start" + "Rental Days";


            end;

        }
        }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    var

    //     myInt: Integer;

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



    procedure EmptyLine():Boolean
    begin
        exit(("Rental Order No." = '') and ("Rental Start" = 0D) and ("Rental End" = 0D) and ("Rental Days" = 0));
    end;

}