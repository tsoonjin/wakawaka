class GameRoom {
    final String id;
    final bool isPublic;
    final int minPlayers;
    final int maxPlayers;
    final String name;
    final int currentPlayers;

    GameRoom({
        required this.id,
        required this.isPublic,
        required this.minPlayers,
        required this.maxPlayers,
        required this.name,
        required this.currentPlayers
    });

    factory GameRoom.fromCSV(List<String> csv) {
        return GameRoom(
            id: csv[0],
            isPublic: csv[1] == 'true' ? true : false,
            minPlayers: int.parse(csv[2]),
            maxPlayers: int.parse(csv[3]),
            name: csv[4],
            currentPlayers: int.parse(csv[5]
        ));
    }

    factory GameRoom.fromJson(Map<String, dynamic> json) {
        return GameRoom(
            id: json['id'],
            isPublic: json['isPublic'],
            minPlayers: json['minPlayers'],
            maxPlayers: json['maxPlayers'],
            name: json['name'],
            currentPlayers: json['currentPlayers']
        );
    }
}
