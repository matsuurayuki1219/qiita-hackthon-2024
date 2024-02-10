import { Test, TestingModule } from '@nestjs/testing';
import { PrisesController } from './prises.controller';

describe('PrisesController', () => {
  let controller: PrisesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PrisesController],
    }).compile();

    controller = module.get<PrisesController>(PrisesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
