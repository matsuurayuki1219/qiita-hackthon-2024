import { ApiProperty } from '@nestjs/swagger';
import { User } from 'src/entities/User';

export class UserResponse {
  constructor(
    id: number,
    name: string,
    status: User['status'],
    image_url: string,
  ) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.image_url = image_url;
  }

  public static fromEntity(user: User): UserResponse {
    return new UserResponse(user.id, user.name, user.status, user.image_url);
  }

  @ApiProperty({ example: 1, description: 'The unique identifier of the User' })
  id: number;
  @ApiProperty({ example: 'John Doe', description: 'The name of the User' })
  name: string;
  @ApiProperty({ example: 'submitter', description: 'The status of the User' })
  status: User['status'];
  @ApiProperty({
    example:
      'https://storage.cloud.google.com/qiita_hackthon_2024/IMGP3906_1_1.png',
    description: 'The image of the User',
  })
  image_url: string;
}
