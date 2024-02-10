import { ApiProperty } from '@nestjs/swagger';

export class Comment {
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
