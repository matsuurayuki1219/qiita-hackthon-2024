import { ApiProperty } from '@nestjs/swagger';
import { Stamp } from 'src/entities/Stamp';

export class StampResponse {
  constructor(id: number, from_user_id: number, stamp: string) {
    this.id = id;
    this.from_user_id = from_user_id;
    this.stamp = stamp;
  }

  public static fromEntity(stamp: Stamp) {
    return new StampResponse(stamp.id, stamp.fromUser.id, stamp.stamp);
  }

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
