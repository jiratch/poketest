class PokemonDetail {
  List<Abilities>? abilities;
  int? height;
  int? id;
  String? name;
  Sprites? sprites;
  List<Stats>? stats;
  List<Types>? types;
  int? weight;

  PokemonDetail(
      {this.abilities,
      this.height,
      this.id,
      this.name,
      this.sprites,
      this.stats,
      this.types,
      this.weight});

  PokemonDetail.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      abilities = <Abilities>[];
      json['abilities'].forEach((v) {
        abilities!.add(new Abilities.fromJson(v));
      });
    }
    height = json['height'];
    id = json['id'];
    name = json['name'];
    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(new Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
      });
    }
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.abilities != null) {
      data['abilities'] = this.abilities!.map((v) => v.toJson()).toList();
    }
    data['height'] = this.height;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.sprites != null) {
      data['sprites'] = this.sprites!.toJson();
    }
    if (this.stats != null) {
      data['stats'] = this.stats!.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    return data;
  }
}

class Abilities {
  Ability? ability;
  bool? isHidden;
  int? slot;

  Abilities({this.ability, this.isHidden, this.slot});

  Abilities.fromJson(Map<String, dynamic> json) {
    ability =
        json['ability'] != null ? new Ability.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ability != null) {
      data['ability'] = this.ability!.toJson();
    }
    data['is_hidden'] = this.isHidden;
    data['slot'] = this.slot;
    return data;
  }
}

class Ability {
  String? name;
  String? url;

  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Sprites {
  Other? other;

  Sprites({this.other});

  Sprites.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? new Other.fromJson(json['other']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.other != null) {
      data['other'] = this.other!.toJson();
    }
    return data;
  }
}

class Other {
  OfficialArtwork? officialArtwork;

  Other({this.officialArtwork});

  Other.fromJson(Map<String, dynamic> json) {
    officialArtwork = json['official-artwork'] != null
        ? new OfficialArtwork.fromJson(json['official-artwork'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.officialArtwork != null) {
      data['official-artwork'] = this.officialArtwork!.toJson();
    }
    return data;
  }
}

class OfficialArtwork {
  String? frontDefault;
  String? frontShiny;

  OfficialArtwork({this.frontDefault, this.frontShiny});

  OfficialArtwork.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['front_default'] = this.frontDefault;
    data['front_shiny'] = this.frontShiny;
    return data;
  }
}

class Stats {
  int? baseStat;
  int? effort;
  Ability? stat;

  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? new Ability.fromJson(json['stat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_stat'] = this.baseStat;
    data['effort'] = this.effort;
    if (this.stat != null) {
      data['stat'] = this.stat!.toJson();
    }
    return data;
  }
}

class Types {
  int? slot;
  Ability? type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Ability.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}
