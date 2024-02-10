import { ApiProperty } from '@nestjs/swagger';

export class Stamp {
  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the Stamp',
  })
  id: number;
  @ApiProperty({
    example: 1,
    description: 'The unique identifier of the User who posted the Stamp',
  })
  from_user_id: number;
  @ApiProperty({
    example: '👍',
    description: 'The content of the Stamp',
  })
  stamp: string;
}
