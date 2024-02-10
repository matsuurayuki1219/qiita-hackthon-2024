import { ApiProperty } from '@nestjs/swagger';
import { UserResponse } from '../user-response/user-response';

export class LoginResponse extends UserResponse {
  @ApiProperty({
    example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
    description: 'The access token of the User',
  })
  access_token: string;
}
