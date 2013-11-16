function makeTurn (rowClicked, colClicked) //отрефакторить
{

    if (attackMenu.moveButtonChosen)
    {
        if (gameField.cellAt(rowClicked, colClicked).isEmpty && gameField.cellAt(rowClicked, colClicked).highlighted)
        {
            var tempRow = players[curPlayer].playerUnits[curUnit].curRow
            var tempCol = players[curPlayer].playerUnits[curUnit].curCol
            gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                             , players[curPlayer].playerUnits[curUnit].curCol
                                             , false);
            gameField.occupyCell(players[curPlayer].playerUnits[curUnit], rowClicked, colClicked)
            players[curPlayer].playerUnits[curUnit].curRow = rowClicked
            players[curPlayer].playerUnits[curUnit].curCol = colClicked

            gameField.clearCell(tempRow, tempCol)

            attackMenu.moveButtonChosen = false

            var horizOffset = Math.abs(tempCol - colClicked);
            var vertOffset = Math.abs(tempRow - rowClicked);
            players[curPlayer].playerUnits[curUnit].movingRangeLeft -= horizOffset + vertOffset;

            if (players[curPlayer].playerUnits[curUnit].movingRangeLeft > 0)
            {
                unitTurn();
            }
            else
            {
                players[curPlayer].playerUnits[curUnit].movingRangeLeft =
                        players[curPlayer].playerUnits[curUnit].movingRange;
                nextUnit();
            }
        }
        else
        {

        }
    }
    if (attackMenu.prAttackButtonChosen)
    {//реализовать обход препятствий
        if (!gameField.cellAt(rowClicked, colClicked).isEmpty) //поправить баг с передачей хода при попытке атаки своего
        {

            var horizOffset1 = Math.abs(players[curPlayer].playerUnits[curUnit].curCol - colClicked);
            var vertOffset1 = Math.abs(players[curPlayer].playerUnits[curUnit].curRow - rowClicked);
            if (horizOffset1 + vertOffset1 <= players[curPlayer].playerUnits[curUnit].primaryAttackRange)
            {
                gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                                 , players[curPlayer].playerUnits[curUnit].curCol
                                                 , false);

                attackMenu.prAttackButtonChosen = false;

                for (var i = 0; i < players[1- curPlayer].unitCount; i++)
                {
                    if (rowClicked == players[1 - curPlayer].playerUnits[i].curRow &&
                            colClicked == players[1 - curPlayer].playerUnits[i].curCol)
                    {
                        players[1 - curPlayer].playerUnits[i].hurt(
                                    players[curPlayer].playerUnits[curUnit].primaryAttackDamage);
                        /*players[1-curPlayer].playerUnits[i].healthBar.changeHpInfo(
                                    players[1 - curPlayer].playerUnits[i].maxHp
                                    , players[1 - curPlayer].playerUnits[i].averageHealth)*/
                        players[1 - curPlayer].playerUnits[i].changeHpInfo();
                        if (players[1 - curPlayer].playerUnits[i].averageHealth <= 0)
                        {
                            gameField.clearCell(players[1 - curPlayer].playerUnits[i].curRow,
                                      players[1 - curPlayer].playerUnits[i].curCol)
                            for (var j = i; j < players[1 - curPlayer].unitCount - 1; j++)
                            {
                                players[1 - curPlayer].playerUnits[j] = players[1 - curPlayer].playerUnits[j + 1]
                            }
                            players[1 - curPlayer].unitCount--
                        }
                        break;
                    }
                }
            }
            else
            {
                unitTurn();
            }

            players[curPlayer].playerUnits[curUnit].movingRangeLeft =
                    players[curPlayer].playerUnits[curUnit].movingRange;
            nextUnit();

        }
        else
        {
            unitTurn();
        }
    }
}
