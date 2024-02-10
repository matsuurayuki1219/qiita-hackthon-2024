import { ApiProperty } from '@nestjs/swagger';
import { UserResponse } from '../user-response/user-response';
import { CommentResponse } from '../comment-response/comment-response';
import { StampResponse } from '../stamp-response/stamp-response';
import { Praise } from 'src/entities/Praise';

export class PraiseResponse {
  constructor(
    id: number,
    description: string,
    to_user_id: UserResponse['id'],
    from_user_id: UserResponse['id'],
    comments: CommentResponse[],
    stamps: StampResponse[],
  ) {
    this.id = id;
    this.description = description;
    this.to_user_id = to_user_id;
    this.from_user_id = from_user_id;
    this.comments = comments;
    this.stamps = stamps;
  }

  public static fromEntity(praise: Praise): PraiseResponse {
    return new PraiseResponse(
      praise.id,
      praise.description,
      praise.toUser.id,
      praise.fromUser.id,
      praise.comments?.map(CommentResponse.fromEntity) ?? [],
      praise.stamps?.map(StampResponse.fromEntity) ?? [],
    );
  }
  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the Praise',
  })
  id: number;
  @ApiProperty({
    example: '神がかった掃除でした',
    description: '称賛する内容のタイトル',
  })
  title: string;

  @ApiProperty({
    example: 'とても綺麗に掃除してくれて感謝しています',
    description: '称賛する内容',
  })
  description: string;

  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the User who posted the Praise',
  })
  to_user_id: UserResponse['id'];

  @ApiProperty({
    example: 2,
    description: 'The unique identifier of the User who received the Praise',
  })
  from_user_id: UserResponse['id'];

  @ApiProperty({
    type: CommentResponse,
    isArray: true,
    description: 'The comments of the Praise',
  })
  comments: CommentResponse[];

  @ApiProperty({
    type: StampResponse,
    isArray: true,
    description: 'The stamps of the Praise',
  })
  stamps: StampResponse[];
}
