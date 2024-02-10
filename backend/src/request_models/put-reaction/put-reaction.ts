import { ApiProperty } from '@nestjs/swagger';

export class PutReaction {
  @ApiProperty({ description: 'The comment of the Reaction' })
  comment: string;
  @ApiProperty({ description: 'The emoji of the Reaction' })
  emoji: string;
}
