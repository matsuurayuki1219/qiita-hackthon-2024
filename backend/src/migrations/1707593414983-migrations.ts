import { MigrationInterface, QueryRunner } from "typeorm";

export class Migrations1707593414983 implements MigrationInterface {
    name = 'Migrations1707593414983'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE \`user\` (\`created_at\` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP, \`updated_at\` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, \`id\` int NOT NULL AUTO_INCREMENT, \`name\` varchar(255) NOT NULL, \`status\` enum ('submitter', 'waiting', 'praised', 'others') NOT NULL DEFAULT 'waiting', \`image_url\` text NOT NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`stamp\` (\`created_at\` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP, \`updated_at\` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, \`id\` int NOT NULL AUTO_INCREMENT, \`stamp\` varchar(255) NOT NULL, \`praise_id\` int NULL, \`from_user_id\` int NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`comment\` (\`created_at\` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP, \`updated_at\` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, \`id\` int NOT NULL AUTO_INCREMENT, \`comment\` text NOT NULL, \`praise_id\` int NULL, \`from_user_id\` int NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`praise\` (\`created_at\` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP, \`updated_at\` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, \`id\` int NOT NULL AUTO_INCREMENT, \`description\` text NOT NULL, \`fromUserId\` int NULL, \`toUserId\` int NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`ALTER TABLE \`stamp\` ADD CONSTRAINT \`FK_342bb8fb4c6270e2040e73a1575\` FOREIGN KEY (\`praise_id\`) REFERENCES \`praise\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`stamp\` ADD CONSTRAINT \`FK_8dd4d942413f1eb73c205ce2038\` FOREIGN KEY (\`from_user_id\`) REFERENCES \`user\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`comment\` ADD CONSTRAINT \`FK_1ef91fe78331907af56ec0a70ef\` FOREIGN KEY (\`praise_id\`) REFERENCES \`praise\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`comment\` ADD CONSTRAINT \`FK_07753853aa2804f572c278c70e9\` FOREIGN KEY (\`from_user_id\`) REFERENCES \`user\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`praise\` ADD CONSTRAINT \`FK_3b5e8f47302bb786969845696c4\` FOREIGN KEY (\`fromUserId\`) REFERENCES \`user\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`praise\` ADD CONSTRAINT \`FK_d69e461a07186cb3fe618d31816\` FOREIGN KEY (\`toUserId\`) REFERENCES \`user\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`praise\` DROP FOREIGN KEY \`FK_d69e461a07186cb3fe618d31816\``);
        await queryRunner.query(`ALTER TABLE \`praise\` DROP FOREIGN KEY \`FK_3b5e8f47302bb786969845696c4\``);
        await queryRunner.query(`ALTER TABLE \`comment\` DROP FOREIGN KEY \`FK_07753853aa2804f572c278c70e9\``);
        await queryRunner.query(`ALTER TABLE \`comment\` DROP FOREIGN KEY \`FK_1ef91fe78331907af56ec0a70ef\``);
        await queryRunner.query(`ALTER TABLE \`stamp\` DROP FOREIGN KEY \`FK_8dd4d942413f1eb73c205ce2038\``);
        await queryRunner.query(`ALTER TABLE \`stamp\` DROP FOREIGN KEY \`FK_342bb8fb4c6270e2040e73a1575\``);
        await queryRunner.query(`DROP TABLE \`praise\``);
        await queryRunner.query(`DROP TABLE \`comment\``);
        await queryRunner.query(`DROP TABLE \`stamp\``);
        await queryRunner.query(`DROP TABLE \`user\``);
    }

}
