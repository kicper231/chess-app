import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/models/square.dart';
import 'package:chessproject/datalayer/repo/repo.dart';
import 'package:flutter/material.dart';

class ChessBoard {
  Map<int, Square?> board = {};

  ChessBoard() {
    _initboard();
  }
  void resetvalidmoves() {
    board.forEach((key, value) {
      value!.isValid = false;
    });
  }

  void validMoves(int index, bool isSimulation, bool isWhiteTurn) {
    ChessPiece? choosen = ChessPiece(
        type: board[index]!.figure!.type,
        isWhite: board[index]!.figure!.isWhite);
    int direction = choosen!.isWhite ? -1 : 1;

    int row = index ~/ 8;
    int column = index % 8;

    switch (choosen.type) {
      // pawn
      case PieceType.Pawn:
        if (onBoard(row, column) &&
            onBoard((row + direction), column) &&
            board[(row + direction) * 8 + column]?.figure == null) {
          board[(row + direction) * 8 + column]!.isValid = true;
        }

        if (onBoard(row, column) &&
            onBoard(row + direction * 2, column) &&
            (row == 6 || row == 1) &&
            board[(row + direction) * 8 + column]?.figure == null &&
            board[(indexmaker(row + direction * 2, column))]?.figure == null) {
          board[indexmaker((row + 2 * direction), column)]!.isValid = true;
        }
        // zbicia

        if (onBoard(row + direction, column - 1) &&
            isFigure(row + direction, column - 1) &&
            board[indexmaker(row + direction, column - 1)]!.figure!.isWhite !=
                choosen.isWhite) {
          board[indexmaker((row + direction), column - 1)]!.isValid = true;
        }
        if (onBoard(row + direction, column + 1) &&
            isFigure(row + direction, column + 1) &&
            board[indexmaker(row + direction, column + 1)]!.figure!.isWhite !=
                choosen.isWhite) {
          board[indexmaker((row + direction), column + 1)]!.isValid = true;
        }
        break;

      case PieceType.Rook:
        var directions = [
          [-1, 0],
          [0, 1],
          [1, 0],
          [0, -1]
        ];

        for (var direction in directions) {
          int i = 1;
          while (true) {
            int newrow = i * direction[0] + row;
            int newcolumn = i * direction[1] + column;

            if (!onBoard(newrow, newcolumn)) break;

            if (isFigure(newrow, newcolumn)) {
              if (board[indexmaker(newrow, newcolumn)]!.figure!.isWhite !=
                  choosen.isWhite) {
                board[indexmaker(newrow, newcolumn)]!.isValid = true;
              }
              break;
            }
            board[indexmaker(newrow, newcolumn)]!.isValid = true;
            i++;
          }
        }

        break;
      case PieceType.King:
        {
          var directions = [
            [-1, 0],
            [0, 1],
            [1, 0],
            [0, -1],
            [-1, 1],
            [1, 1],
            [1, -1],
            [-1, -1]
          ];
          for (var direction in directions) {
            int newrow = direction[0] + row;
            int newcolumn = direction[1] + column;

            if (!onBoard(newrow, newcolumn)) {
              continue;
            }

            if (isFigure(newrow, newcolumn)) {
              if (board[indexmaker(newrow, newcolumn)]!.figure!.isWhite !=
                  choosen.isWhite) {
                board[indexmaker(newrow, newcolumn)]!.isValid = true;
              }
              continue;
            }

            board[indexmaker(newrow, newcolumn)]!.isValid = true;
          }

          break;
        }

      case PieceType.Queen:
        {
          var directions = [
            [-1, 0],
            [0, 1],
            [1, 0],
            [0, -1],
            [-1, 1],
            [1, 1],
            [1, -1],
            [-1, -1]
          ];
          for (var direction in directions) {
            int i = 1;
            while (true) {
              int newrow = i * direction[0] + row;
              int newcolumn = i * direction[1] + column;

              if (!onBoard(newrow, newcolumn)) {
                break;
              }

              if (isFigure(newrow, newcolumn)) {
                if (board[indexmaker(newrow, newcolumn)]!.figure!.isWhite !=
                    choosen.isWhite) {
                  board[indexmaker(newrow, newcolumn)]!.isValid = true;
                }
                break;
              }

              board[indexmaker(newrow, newcolumn)]!.isValid = true;
              i++;
            }
          }

          break;
        }

      case PieceType.Knight:
        {
          var directions = [
            [2, 1],
            [-2, 1],
            [2, -1],
            [-2, -1],
            [1, 2],
            [-1, 2],
            [1, -2],
            [-1, -2],
          ];

          for (var direction in directions) {
            int newrow = direction[0] + row;
            int newcolumn = direction[1] + column;

            if (!onBoard(newrow, newcolumn)) {
              continue;
            }

            if (isFigure(newrow, newcolumn)) {
              if (board[indexmaker(newrow, newcolumn)]!.figure!.isWhite !=
                  choosen.isWhite) {
                board[indexmaker(newrow, newcolumn)]!.isValid = true;
              }
              continue;
            }

            board[indexmaker(newrow, newcolumn)]!.isValid = true;
          }
          break;
        }
      case PieceType.Bishop:
        {
          var directions = [
            [-1, 1],
            [1, 1],
            [1, -1],
            [-1, -1]
          ];

          for (var direction in directions) {
            int i = 1;
            while (true) {
              int newrow = i * direction[0] + row;
              int newcolumn = i * direction[1] + column;

              if (!onBoard(newrow, newcolumn)) {
                break;
              }

              if (isFigure(newrow, newcolumn)) {
                if (board[indexmaker(newrow, newcolumn)]!.figure!.isWhite !=
                    choosen.isWhite) {
                  board[indexmaker(newrow, newcolumn)]!.isValid = true;
                }
                break;
              }

              board[indexmaker(newrow, newcolumn)]!.isValid = true;
              i++;
            }
          }
          break;
        }
      default:
    }
    List<int> novalid = [];
    if (!isSimulation) {
      board.forEach((key, value) {
        if (value!.isValid == true) {
          ChessPiece? copy = null;
          if (value.figure != null) {
            copy = ChessPiece(
                type: value!.figure!.type, isWhite: value!.figure!.isWhite);
          }
          ChessPiece? copy2 = null;
          if (choosen != null) {
            copy2 = ChessPiece(type: choosen.type, isWhite: choosen!.isWhite);
          }

          value.figure = copy2;
          board[index]!.figure = null;

          bool good = true;
          resetvalidmoves();
          if (kingCheck(isWhiteTurn)) {
            good = false;
          }

          board[index]!.figure = copy2;
          value!.figure = copy;
          validMoves(index, true, isWhiteTurn);

          if (!good) novalid.add(key);
        }
      });

      novalid.forEach((element) {
        board[element]!.isValid = false;
      });
    }
  }

  void _initboard() {
    for (int i = 0; i < 64; i++) {
      bool isWhiteSquare = ((i ~/ 8) % 2 == 0) ? i % 2 == 0 : i % 2 != 0;
      board[i] =
          Square(isWhite: isWhiteSquare, isChoose: false, isValid: false);
    }
    //  black side
    board[0]?.figure = ChessPiece(type: PieceType.Rook, isWhite: false);
    board[7]?.figure = ChessPiece(type: PieceType.Rook, isWhite: false);
    board[1]?.figure = ChessPiece(type: PieceType.Knight, isWhite: false);
    board[6]?.figure = ChessPiece(type: PieceType.Knight, isWhite: false);
    board[2]?.figure = ChessPiece(type: PieceType.Bishop, isWhite: false);
    board[5]?.figure = ChessPiece(type: PieceType.Bishop, isWhite: false);
    board[3]?.figure = ChessPiece(type: PieceType.Queen, isWhite: false);
    board[4]?.figure = ChessPiece(type: PieceType.King, isWhite: false);
    for (int i = 8; i < 8 * 2; i++) {
      board[i]?.figure = ChessPiece(type: PieceType.Pawn, isWhite: false);
    }

    board[56]?.figure = ChessPiece(type: PieceType.Rook, isWhite: true);
    board[63]?.figure = ChessPiece(type: PieceType.Rook, isWhite: true);
    board[57]?.figure = ChessPiece(type: PieceType.Knight, isWhite: true);
    board[62]?.figure = ChessPiece(type: PieceType.Knight, isWhite: true);
    board[58]?.figure = ChessPiece(type: PieceType.Bishop, isWhite: true);
    board[61]?.figure = ChessPiece(type: PieceType.Bishop, isWhite: true);
    board[59]?.figure = ChessPiece(type: PieceType.Queen, isWhite: true);
    board[60]?.figure = ChessPiece(type: PieceType.King, isWhite: true);
    for (int i = 48; i < 8 * 7; i++) {
      board[i]?.figure = ChessPiece(type: PieceType.Pawn, isWhite: true);
    }
  }

  bool kingCheck(bool isWhite) {
    ChessPiece king;
    int kingi = 0;
    bool isCheck = false;
    board.forEach((key, value) {
      if (value!.figure != null &&
          value!.figure!.type == PieceType.King &&
          value.figure!.isWhite == isWhite) {
        king = value.figure!;
        kingi = key;
      }
    });

    board.forEach((key, value) {
      if (value!.figure != null && value!.figure!.isWhite != isWhite) {
        validMoves(key, true, isWhite);
        board.forEach((key, value) {
          if (key == kingi && value!.isValid) {
            isCheck = true;
          }
        });
      }
    });
    board.forEach((key, value) {
      value!.isValid = false;
    });
    return isCheck;
  }

  bool onBoard(int row, int column) {
    if (row < 8 && row >= 0 && column < 8 && column >= 0) return true;
    return false;
  }

  int indexmaker(int row, int column) {
    return row * 8 + column;
  }

  bool isCheckMate(bool isWhite) {
    bool isCheckmate = true;
    board.forEach((key, value) {
      if (value!.figure != null && value!.figure!.isWhite == isWhite) {
        validMoves(key, false, false);
        board.forEach((key, value) {
          if (value!.isValid == true) {
            isCheckmate = false;
          }
        });
      }
    });

    resetvalidmoves();
    return isCheckmate;
  }

  bool isFigure(int row, int column) {
    if (board[(indexmaker(row, column))]?.figure != null) {
      return true;
    } else {
      return false;
    }
  }
}
