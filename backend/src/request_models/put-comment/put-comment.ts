import { ApiProperty } from '@nestjs/swagger';

export class PutComment {
  @ApiProperty({
    example: 'とても綺麗に掃除してくれて感謝しています',
    description: 'The content of the Comment',
  })
  comment: string;
}
