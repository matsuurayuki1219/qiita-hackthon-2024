import { ApiProperty } from '@nestjs/swagger';
import { User } from '../user/user';
import { Stamp } from '../stamp/stamp';
import { Comment } from '../comment/comment';

export class Praise {
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
    type: Stamp,
    isArray: true,
    description: 'The stamps of the Praise',
  })
  stamps: Stamp[];
}
