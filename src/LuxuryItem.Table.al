table 50204 "Luxury Item"
{
    DataCaptionFields = "No.", Description;
    Caption = 'Luxury Item';
    DrillDownPageId = "Luxury Item List";
    LookupPageId = "Luxury Item List";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    RentalSetup.Get();
                    NoSeriesMgtCodeunit.TestManual(RentalSetup."Rental Item Nos");
                    Rec."No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
        }
        field(13; "Responsible Employee"; Text[100])
        {
            Caption = 'Responsible Employee';
            TableRelation = Employee;
        }
        field(4; "Luxury Item Category Code"; Code[10])
        {
            Caption = 'Luxury Item Category Code';
            TableRelation = "Luxury Clothing class";
        }
        field(5; "Brand"; Code[20])
        {
            Caption = 'Brand';
        }
        field(6; "Model"; Code[20])
        {
            Caption = 'Model';
        }
        field(7; "Color"; Code[20])
        {
            Caption = 'Color';
        }
        field(8; "Material"; Code[20])
        {
            Caption = 'Material';
        }
        field(9; "Price"; Decimal)
        {
            Caption = 'Daily price rate';
            DecimalPlaces = 2;
        }

        field(10; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(30; "RentalCount"; Integer)
        {
            Caption = 'Rental Count';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Luxury Item No."; Code[20])
        {
            Caption = 'Luxury Item No.';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Description")
        {
        }
        key(Key3; "Luxury Item Category Code")
        {
        }
        key(Key4; Brand)
        {
        }
        key(Key5; Model)
        {
        }
    }

    var
        LuxuryItem: Record "Luxury Item";
        RentalSetup: Record "Rental Setup";
        NoSeriesMgtCodeunit: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        // InitLuxeNo();
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

    procedure AssistEdit(OldLuxe: Record "Luxury Item") Result: Boolean
    begin
        LuxuryItem := Rec;
        RentalSetup.Get();
        RentalSetup.TestField("Rental Item Nos");
        if NoSeriesMgtCodeunit.SelectSeries(RentalSetup."Rental Item Nos", OldLuxe."No. Series", LuxuryItem."No. Series") then begin
            NoSeriesMgtCodeunit.SetSeries(LuxuryItem."No.");
            Rec := LuxuryItem;
            exit(true);
        end;
    end;

    procedure UpdateRentalCount(LuxuryItemNo: Code[20]; Increment: Integer)
    var
        LuxuryItem: Record "Luxury Item";
    begin
        if LuxuryItem.Get(LuxuryItemNo) then begin
            LuxuryItem.RentalCount += Increment;
            LuxuryItem.Modify();
        end;
    end;


    // local procedure InitLuxeNo()
    // begin
    //     if "No." = '' then begin
    //         RentalSetup.Get();
    //         RentalSetup.TestField("Rental Item Nos");
    //         NoSeriesMgtCodeunit.InitSeries(RentalSetup."Rental Item Nos", xRec."No. Series", 0D, "No.", "No. Series");
    //         end;
    //     end;

    //     [IntegrationEvent(false, false)]
    //     local procedure OnBeforeValidateShortcutDimCode(var LuxuryItem: Record "Luxury Item"; var xRentalAsset: Record "Luxury Item"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    //     begin
    //     end;

}