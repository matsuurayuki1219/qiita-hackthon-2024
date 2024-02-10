import { ApiProperty } from '@nestjs/swagger';

export class PutReaction {
  @ApiProperty({
    example: '素晴らしい！',
    description: 'The comment of the Reaction',
  })
  comment: string;
  @ApiProperty({ example: '👍', description: 'The emoji of the Reaction' })
  emoji: string;
}
