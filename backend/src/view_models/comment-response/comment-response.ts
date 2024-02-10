import { ApiProperty } from '@nestjs/swagger';
import { Comment } from 'src/entities/Comment';

export class CommentResponse {
  constructor(id: number, from_user_id: number, comment: string) {
    this.id = id;
    this.from_user_id = from_user_id;
    this.comment = comment;
  }
  public static fromEntity(comment: Comment): CommentResponse {
    return new CommentResponse(
      comment.id,
      comment.fromUser.id,
      comment.comment,
    );
  }

  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the Comment',
  })
  id: number;
  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the User who posted the Comment',
  })
  from_user_id: number;
  @ApiProperty({
    example: 'とても綺麗に掃除してくれて感謝しています',
    description: 'The content of the Comment',
  })
  comment: string;
}
