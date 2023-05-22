codeunit 50201 "Rental Jnl.-Post Line"
{
    Permissions = TableData "Luxury Rental Ledger Entry" = imd;
    TableNo = "Rental Journal Line";

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    var
        //  myInt: Integer;
        RentalJnlLine: Record "Rental Journal Line";
        RentalJnlCheckLine: Codeunit "Rental Jnl.-Check Line";
        LuxuryItem: Record "Luxury Item";
        LuxuryItemRentalUnit: Record "Luxury Item Rental Unit";
        LuxuryRentalLedgEntry: Record "Luxury Rental Ledger Entry";
        LuxuryRentalLedgEntryHist: Record "Luxury Rental Ledger Entry";

        EntryAlreadyExistsErr: Label '%1 entry for Rental Order %2 already exists.';


    procedure RunCheck(var _RentalJnlLine: Record "Rental Journal Line")
    begin
        RentalJnlLine.Copy(_RentalJnlLine);
        Code();
        _RentalJnlLine := RentalJnlLine;
    end;

    local procedure "Code"()
    var
        _intDays: Integer;
    begin
        with RentalJnlLine do begin
            if EmptyLine() then
                exit;

            RentalJnlCheckLine.RunCheck(RentalJnlLine);

            LuxuryItem.Get("Luxury Rental Item No.");
            LuxuryItemRentalUnit.Get("Luxury Rental Item No.", "Luxury Item Rental Unit No.");

            LuxuryItem.TestField(Blocked, false);
            LuxuryItemRentalUnit.TestField(Blocked, false);

            Clear(LuxuryRentalLedgEntry);
            LuxuryRentalLedgEntry.Init();
            LuxuryRentalLedgEntry.CopyFromRentalJnlLine(RentalJnlLine);

            case "Entry Type" of
                "Entry Type"::"Hand Over":
                    begin
                        LuxuryRentalLedgEntryHist.Reset();
                        LuxuryRentalLedgEntryHist.SetCurrentKey("Entry Type", "Rental Order No.");
                        LuxuryRentalLedgEntryHist.SetRange("Entry Type", "Rental Ledger Entry Type"::"Hand over");
                        LuxuryRentalLedgEntryHist.SetRange("Rental Order No.", "Rental Order No.");
                        if not LuxuryRentalLedgEntryHist.IsEmpty then
                            Error(EntryAlreadyExistsErr, "Entry Type", "Rental Order No.");
                        LuxuryRentalLedgEntry."Days (Expected)" := "Rental Days";
                    end;
                "Entry Type"::Extend:
                    begin
                        LuxuryRentalLedgEntryHist.Reset();
                        LuxuryRentalLedgEntryHist.SetCurrentKey("Entry Type", "Rental Order No.");
                        LuxuryRentalLedgEntryHist.SetRange("Entry Type", "Rental Ledger Entry Type"::"Hand over");
                        LuxuryRentalLedgEntryHist.SetRange("Rental Order No.", "Rental Order No.");
                        LuxuryRentalLedgEntryHist.FindFirst();
                        _intDays := LuxuryRentalLedgEntryHist."Days (Expected)";

                        LuxuryRentalLedgEntryHist.Reset();
                        LuxuryRentalLedgEntryHist.SetCurrentKey("Entry Type", "Rental Order No.");
                        LuxuryRentalLedgEntryHist.SetRange("Entry Type", "Rental Ledger Entry Type"::Extend);
                        LuxuryRentalLedgEntryHist.SetRange("Rental Order No.", "Rental Order No.");
                        if LuxuryRentalLedgEntryHist.FindSet() then
                            repeat
                                _intDays += LuxuryRentalLedgEntryHist."Days (Expected)";
                            until LuxuryRentalLedgEntryHist.Next() = 0;

                        LuxuryRentalLedgEntry."Days (Expected)" := "Rental Days" - _intDays;
                    end;
                "Entry Type"::Return:
                    begin
                        LuxuryRentalLedgEntryHist.Reset();
                        LuxuryRentalLedgEntryHist.SetCurrentKey("Entry Type", "Rental Order No.");
                        LuxuryRentalLedgEntryHist.SetRange("Entry Type", "Rental Ledger Entry Type"::Return);
                        LuxuryRentalLedgEntryHist.SetRange("Rental Order No.", "Rental Order No.");
                        if not LuxuryRentalLedgEntryHist.IsEmpty then
                            Error(EntryAlreadyExistsErr, "Entry Type", "Rental Order No.");
                        LuxuryRentalLedgEntry."Days (Actual)" := "Rental Days";
                    end;
                "Entry Type"::Lost:
                    begin
                        //ToDo
                    end;
                "Entry Type"::"Rental Invoice":
                    begin
                        //ToDo
                    end;
                "Entry Type"::"Penalty Invoice":
                    begin
                        //ToDo
                    end;
            end;

            LuxuryRentalLedgEntry.Insert(true);
        end;
    end;
}
