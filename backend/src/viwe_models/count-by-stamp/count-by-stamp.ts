import { ApiProperty } from '@nestjs/swagger';

export class CountByStamp {
  @ApiProperty({
    example: '👍',
    description: 'The content of the Stamp',
  })
  stamp: string;
  @ApiProperty({
    example: 1,
    description: 'The count of the Stamp',
  })
  count: number;
}
