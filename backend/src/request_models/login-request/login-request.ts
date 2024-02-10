import { ApiProperty } from '@nestjs/swagger';

export class LoginRequest {
  @ApiProperty({ example: 'John Doe', description: 'The username of the User' })
  username: string;
}
