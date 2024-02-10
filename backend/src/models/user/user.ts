import { ApiProperty } from '@nestjs/swagger';

export class User {
  @ApiProperty({ example: 1, description: 'The unique identifier of the User' })
  id: number;
  @ApiProperty({ example: 'John Doe', description: 'The name of the User' })
  name: string;
}
