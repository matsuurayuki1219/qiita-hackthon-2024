import { ApiProperty } from '@nestjs/swagger';
import { CountByStamp } from '../count-by-stamp/count-by-stamp';
import { Praise } from 'src/entities/Praise';
import { User } from 'src/entities/User';
import { CommentResponse } from '../comment-response/comment-response';

export class CurrentPraiseResponse {
  constructor(praise: Praise) {
    this.id = praise.id;
    this.description = praise.description;
    this.to_user_id = praise.toUser.id;
    this.from_user_id = praise.fromUser.id;
    this.comments = praise.comments.map(CommentResponse.fromEntity);
    this.stamps = praise.stamps.reduce((acc, stamp) => {
      const existStamp = acc.find((item) => item.stamp === stamp.stamp);
      if (existStamp != null) {
        existStamp.count += 1;
        return acc;
      }
      return [
        ...acc,
        {
          stamp: stamp.stamp,
          count: 1,
        },
      ];
    }, [] as CountByStamp[]);
  }
  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the Praise',
  })
  id: number;

  @ApiProperty({
    example: 'とても綺麗に掃除してくれて感謝しています',
    description: '称賛する内容',
  })
  description: string;

  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the User who posted the Praise',
  })
  to_user_id: User['id'];

  @ApiProperty({
    example: 2,
    description: 'The unique identifier of the User who received the Praise',
  })
  from_user_id: User['id'];

  @ApiProperty({
    type: CommentResponse,
    isArray: true,
    description: 'The comments of the Praise',
  })
  comments: CommentResponse[];

  @ApiProperty({
    type: CountByStamp,
    isArray: true,
    description: 'The stamps of the Praise',
  })
  stamps: CountByStamp[];
}
