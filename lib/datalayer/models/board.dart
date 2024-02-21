import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/models/square.dart';
import 'package:flutter/material.dart';

class ChessBoard {
  Map<int, Square?> board = {};

  ChessBoard() {
    _initboard();
  }

  void validMoves(int index) {
    ChessPiece? choosen = board[index]!.figure;
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
        break;
      default:
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

  bool onBoard(int row, int column) {
    if (row < 8 && row >= 0 && column < 8 && column >= 0) return true;
    return false;
  }

  int indexmaker(int row, int column) {
    return row * 8 + column;
  }

  bool isFigure(int row, int column) {
    if (board[(indexmaker(row, column))]?.figure != null) {
      return true;
    } else {
      return false;
    }
  }
}
