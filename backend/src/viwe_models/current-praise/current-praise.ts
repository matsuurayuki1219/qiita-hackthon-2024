import { Praise } from 'src/models/praise/praise';
import { ApiProperty } from '@nestjs/swagger';
import { User } from 'src/models/user/user';
import { CountByStamp } from '../count-by-stamp/count-by-stamp';
import { Comment } from 'src/models/comment/comment';

export class CurrentPraise {
  constructor(praise: Praise) {
    this.id = praise.id;
    this.title = praise.title;
    this.description = praise.description;
    this.to_user_id = praise.to_user_id;
    this.from_user_id = praise.from_user_id;
    this.comments = praise.comments;
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
  to_user_id: User['id'];

  @ApiProperty({
    example: 2,
    description: 'The unique identifier of the User who received the Praise',
  })
  from_user_id: User['id'];

  @ApiProperty({
    type: Comment,
    isArray: true,
    description: 'The comments of the Praise',
  })
  comments: Comment[];

  @ApiProperty({
    type: CountByStamp,
    isArray: true,
    description: 'The stamps of the Praise',
  })
  stamps: CountByStamp[];
}
