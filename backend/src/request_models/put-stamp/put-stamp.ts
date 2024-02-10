import { ApiProperty } from '@nestjs/swagger';

export class PutStamp {
  @ApiProperty({
    example: '👍',
    description: 'The content of the Stamp',
  })
  stamp: string;
}
