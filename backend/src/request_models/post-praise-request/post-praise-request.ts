import { ApiProperty } from '@nestjs/swagger';

export class PostPriseRequest {
  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the User who posted the Praise',
  })
  to_user_id: number;

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
}
