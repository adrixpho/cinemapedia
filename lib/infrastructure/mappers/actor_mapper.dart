import '../../domain/entities/entities.dart';
import '../models/models.dart';

class ActorMapper {
  static Actor actorFromCast(Cast cast) => Actor(
        id: cast.id ?? 0,
        name: cast.name ?? '',
        character: cast.character ?? '',
        profilePath: (cast.profilePath != null)
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
            : 'https://media.istockphoto.com/id/1316420668/vector/user-icon-human-person-symbol-social-profile-icon-avatar-login-sign-web-user-symbol.jpg?s=612x612&w=0&k=20&c=AhqW2ssX8EeI2IYFm6-ASQ7rfeBWfrFFV4E87SaFhJE=',
      );
}
