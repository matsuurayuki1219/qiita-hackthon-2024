import { ApiProperty } from '@nestjs/swagger';

export class Reaction {
  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the Reaction',
  })
  id: number;
  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the User who posted the Reaction',
  })
  from_user_id: number;
  @ApiProperty({
    example: '最高ですね',
    description: 'The comment of the Reaction',
  })
  comment: string;
  @ApiProperty({
    example: '👍',
    description: 'The emoji of the Reaction',
  })
  emoji: string;
}
