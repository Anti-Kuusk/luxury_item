table 50218 "Luxury Rental Ledger Entry"
{
    
    caption = 'Luxury Item Rental Ledger Entry';
    DrillDownPageID = "Luxury Rental Ledger Entries";
    LookupPageID = "Luxury Rental Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';

        }
        field(2; "Entry Type"; Enum "Rental Ledger Entry Type") //kui tahta ümber nimetada üht süna teiseks, tee aktiivseks ja F2
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

        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(12; "Rental Asset No."; Code[20])
        {
            Caption = 'Rental Asset No.';
            TableRelation = "Luxury Item"."No.";
        }
        field(13; "Rental Asset Unit No."; code[20])
        {
            Caption = 'Rental Asset Unit No.';
            TableRelation = "Luxury Item Rental Unit"."LI Unit No." where("Luxury Item No." = field("Rental Asset No."));

        }
        field(15; "Rental Start"; Date)
        {
            Caption = 'Rental Start';

        }
        field(16; "Rental End"; Date)
        {
            Caption = 'Rental End';

        }
        field(17; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';
        }
        field(18; "Days (Expected)"; Integer)
        {
            Caption = 'Days (Expected)';
        }
        field(19; "Days (Actual)"; Integer)
        {
            Caption = 'Days (Actual)';
        }
        field(20; "Days (Invoiced)"; Integer)
        {
            Caption = 'Days (Invoiced)';
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type","Rental Order No.")
        {
           
        }
    }

    var

       
    //     myInt: Integer;

    trigger OnInsert()
    var
        _RentalLedgerEntry: Record "Luxury Rental Ledger Entry"; 
    begin
        if "Entry No." = 0 then begin
            _RentalLedgerEntry.Reset();
            if _RentalLedgerEntry.FindLast() then
                "Entry No." := _RentalLedgerEntry."Entry No." + 1
            else
                "Entry No." := 1;

        end;
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


    procedure CopyFromRentalJnlLine(RentalJnlLine: Record "Rental Journal Line")
    begin
        "Entry Type" := RentalJnlLine."Entry Type";
        "Document No." := RentalJnlLine."Document No.";
        "Posting Date" := RentalJnlLine."Posting Date";

        "Rental Order No." := RentalJnlLine."Rental Order No.";
        "Customer No." := RentalJnlLine."Customer No.";
        "Rental Asset No." := RentalJnlLine."Luxury Rental Item No.";
        "Rental Asset Unit No." := RentalJnlLine."Luxury Item Rental Unit No.";

        "Rental Start" := RentalJnlLine."Rental Start";
        "Rental End" := RentalJnlLine."Rental End";
        "Rental Days" := RentalJnlLine."Rental Days";
    end;

}