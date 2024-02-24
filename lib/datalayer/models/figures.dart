enum PieceType { Pawn, Rook, Knight, Bishop, King, Queen }

abstract class Piece {
  final bool isWhite;
  final String image;

  Piece({required this.isWhite, required this.image});

  List<int> availableMoves();
}

class ChessPiece extends Piece {
  PieceType type;
  late bool isMoved;
  ChessPiece({
    required this.type,
    required bool isWhite,
    required this.isMoved,
  }) : super(isWhite: isWhite, image: _getImage(type));

  static String _getImage(PieceType type) {
    switch (type) {
      case PieceType.Pawn:
        return 'assets/pieces/pawn.png';
      case PieceType.Rook:
        return 'assets/pieces/rook.png';
      case PieceType.Knight:
        return 'assets/pieces/knight.png';
      case PieceType.Bishop:
        return 'assets/pieces/bishop.png';
      case PieceType.King:
        return 'assets/pieces/king.png';
      case PieceType.Queen:
        return 'assets/pieces/queen.png';
    }
  }

  @override
  List<int> availableMoves() {
    return List.empty();
  }
}
